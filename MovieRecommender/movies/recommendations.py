import numpy as np
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.neighbors import NearestNeighbors
from django.contrib.auth.models import User
from .models import Movie, Genre, Keyword, Rating
from django.db.models import Avg

def get_movie_features():
    # Pobierz dane filmów
    movies = Movie.objects.all()

    # Tworzenie DataFrame z filmami
    data = []
    for movie in movies:
        genres = [genre.name for genre in movie.genres.all()]
        keywords = [keyword.name for keyword in movie.keywords.all()]
        data.append({
            'id': movie.id,
            'title': movie.title,
            'genres': ' '.join(genres),
            'keywords': ' '.join(keywords),
            'description': movie.description,
            'release_year': movie.release_year
        })

    df = pd.DataFrame(data)

    # Przetwarzanie tekstu
    from sklearn.feature_extraction.text import CountVectorizer

    df['text'] = df['genres'] + ' ' + df['keywords'] + ' ' + df['description']

    count_vectorizer = CountVectorizer(stop_words='english')
    count_matrix = count_vectorizer.fit_transform(df['text'])

    return df, count_matrix

def knn_recommendation():
    df, count_matrix = get_movie_features()

    # Dopasowanie modelu KNN
    knn = NearestNeighbors(metric='cosine', algorithm='brute')
    knn.fit(count_matrix)

    # Wybierz losowy film jako punkt odniesienia
    random_movie_idx = np.random.choice(count_matrix.shape[0])
    distances, indices = knn.kneighbors(count_matrix[random_movie_idx], n_neighbors=6)

    recommended_movies = []
    for i in indices.flatten()[1:]:
        movie_id = df.iloc[i]['id']
        movie = Movie.objects.get(id=movie_id)
        recommended_movies.append(movie)

    return recommended_movies

def matrix_factorization_recommendation(user_id):
    # Pobierz oceny użytkowników
    ratings = Rating.objects.all()
    ratings_df = pd.DataFrame(list(ratings.values('user_id', 'movie_id', 'score')))

    # Pivot table
    user_movie_matrix = ratings_df.pivot_table(index='user_id', columns='movie_id', values='score').fillna(0)

    # Konwersja do macierzy
    matrix = user_movie_matrix.values
    user_ids = list(user_movie_matrix.index)
    movie_ids = list(user_movie_matrix.columns)

    # Średnia ocen
    user_ratings_mean = np.mean(matrix, axis=1)
    R_demeaned = matrix - user_ratings_mean.reshape(-1, 1)

    # SVD
    from scipy.sparse.linalg import svds
    U, sigma, Vt = svds(R_demeaned, k=50)
    sigma = np.diag(sigma)

    # Rekonstrukcja macierzy
    all_user_predicted_ratings = np.dot(np.dot(U, sigma), Vt) + user_ratings_mean.reshape(-1, 1)
    preds_df = pd.DataFrame(all_user_predicted_ratings, index=user_ids, columns=movie_ids)

    # Pobierz oceny użytkownika
    user_row_number = user_ids.index(user_id)
    sorted_user_predictions = preds_df.iloc[user_row_number].sort_values(ascending=False)

    # Filmy ocenione przez użytkownika
    user_data = ratings_df[ratings_df.user_id == user_id]
    user_history = user_data.merge(pd.DataFrame({'movie_id': movie_ids}), on='movie_id', how='right')
    user_history = user_history[user_history['score'].isnull()]

    # Rekomendacje
    recommendations = []
    for movie_id in sorted_user_predictions.index:
        if movie_id in user_history['movie_id'].values:
            movie = Movie.objects.get(id=movie_id)
            recommendations.append(movie)
        if len(recommendations) >= 5:
            break

    return recommendations
