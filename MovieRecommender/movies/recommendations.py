# movies/recommendations.py

import os
import sys
import django
import json
import numpy as np
import pandas as pd
from sklearn.metrics.pairwise import linear_kernel
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.neighbors import NearestNeighbors

# Ścieżki do plików modelu
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))  # .../MovieRecommender/movies
PARENT_DIR = os.path.dirname(CURRENT_DIR)                 # .../MovieRecommender

# Dodaj PARENT_DIR do sys.path
sys.path.insert(0, PARENT_DIR)

# Ustawienia Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'MovieRecommender.settings')
django.setup()

# Importy modeli Django
from movies.models import Movie, Rating, FavoriteMovie, RecommendationFeedback
from django.contrib.auth.models import User
from django.db.models import Avg, Count

# Parametry modelu
LATENT_FEATURES = 10
LEARNING_RATE = 0.01
REGULARIZATION = 0.1
EPOCHS = 20

# Licznik nowych ocen od ostatniego retrenowania
NEW_RATINGS_THRESHOLD = 50

# Ścieżki do plików modelu
MODEL_USER_FACTORS_PATH = os.path.join(CURRENT_DIR, 'user_factors.csv')
MODEL_MOVIE_FACTORS_PATH = os.path.join(CURRENT_DIR, 'movie_factors.csv')
MODEL_MAPPINGS_PATH = os.path.join(CURRENT_DIR, 'model_mappings.json')
MODEL_NEW_RATINGS_COUNT_PATH = os.path.join(CURRENT_DIR, 'new_ratings_count.txt')

# -------------------------- #
#   Funkcje Rekomendacji     #
# -------------------------- #

def get_movie_features(movie):
    """
    Pobiera cechy filmu jako połączony string z gatunków, słów kluczowych, obsady i reżyserów.
    """
    genres = ' '.join([genre.name for genre in movie.genres.all()])
    keywords = ' '.join([keyword.name for keyword in movie.keywords.all()])
    cast = ' '.join([member.name for member in movie.cast.all()])
    directors = ' '.join([director.name for director in movie.directors.all()])
    return f"{genres} {keywords} {cast} {directors}"

def knn_recommendation():
    """
    Generuje rekomendacje dla gości (niezalogowanych użytkowników) za pomocą algorytmu KNN opartego na treści.
    Zwraca listę obiektów Movie.
    """
    all_movies = Movie.objects.all()
    if not all_movies.exists():
        return []

    # Tworzenie DataFrame z filmami
    movies_df = pd.DataFrame(list(all_movies.values('id', 'title', 'description')))

    # Dodaj kolumnę z cechami
    movies_df['features'] = movies_df['id'].apply(
        lambda x: get_movie_features(Movie.objects.get(id=x))
    )

    # Przygotuj macierz TF-IDF
    tfidf = TfidfVectorizer(stop_words='english')
    tfidf_matrix = tfidf.fit_transform(movies_df['features'])

    # Użyj algorytmu KNN do znalezienia podobnych filmów
    knn = NearestNeighbors(metric='cosine', algorithm='brute')
    knn.fit(tfidf_matrix)

    # Wybierz losowy film i znajdź 5 najbliższych sąsiadów
    random_idx = np.random.choice(movies_df.index)
    distances, indices = knn.kneighbors(tfidf_matrix[random_idx], n_neighbors=6)  # 6, bo pierwszy to sam film

    recommendations = []
    for idx in indices.flatten():
        if idx != random_idx:
            movie_id = movies_df.iloc[idx]['id']
            movie = Movie.objects.get(id=movie_id)
            recommendations.append(movie)
    return recommendations[:5]

def train_matrix_factorization_model():
    """
    Trenuje model filtracji kolaboratywnej (matrix factorization) na podstawie ocen użytkowników.
    Zapisuje wektory czynników użytkowników i filmów oraz mapowania ID do indeksów.
    """
    # Pobierz wszystkie oceny użytkowników
    ratings = Rating.objects.all()
    if not ratings.exists():
        print("Brak ocen w bazie danych.")
        return None

    # Tworzenie DataFrame z ocenami
    ratings_df = pd.DataFrame(list(ratings.values('user_id', 'movie_id', 'score')))

    # Mapowanie ID użytkowników i filmów na indeksy
    user_ids = ratings_df['user_id'].unique()
    movie_ids = ratings_df['movie_id'].unique()
    user_id_to_index = {int(user_id): int(index) for index, user_id in enumerate(user_ids)}
    movie_id_to_index = {int(movie_id): int(index) for index, movie_id in enumerate(movie_ids)}
    index_to_movie_id = {int(index): int(movie_id) for movie_id, index in movie_id_to_index.items()}

    num_users = len(user_ids)
    num_movies = len(movie_ids)

    # Inicjalizacja wektorów użytkowników i filmów
    np.random.seed(42)  # Ustawienie seed dla reprodukowalności
    user_factors = np.random.normal(scale=1./LATENT_FEATURES, size=(num_users, LATENT_FEATURES))
    movie_factors = np.random.normal(scale=1./LATENT_FEATURES, size=(num_movies, LATENT_FEATURES))

    # Konwersja ocen na listę
    training_data = []
    for row in ratings_df.itertuples():
        user_idx = user_id_to_index[row.user_id]
        movie_idx = movie_id_to_index[row.movie_id]
        rating = row.score
        training_data.append((user_idx, movie_idx, rating))

    # Trening modelu
    for epoch in range(EPOCHS):
        np.random.shuffle(training_data)
        total_loss = 0
        for user_idx, movie_idx, rating in training_data:
            prediction = np.dot(user_factors[user_idx], movie_factors[movie_idx])
            error = rating - prediction

            # Aktualizacja wektorów z regularizacją
            user_factors[user_idx] += LEARNING_RATE * (
                error * movie_factors[movie_idx] - REGULARIZATION * user_factors[user_idx]
            )
            movie_factors[movie_idx] += LEARNING_RATE * (
                error * user_factors[user_idx] - REGULARIZATION * movie_factors[movie_idx]
            )

            total_loss += error ** 2

        rmse = np.sqrt(total_loss / len(training_data))
        print(f"Epoka {epoch+1}/{EPOCHS}, RMSE: {rmse:.4f}")

    # Zapisz wyuczone parametry do plików CSV
    np.savetxt(MODEL_USER_FACTORS_PATH, user_factors, delimiter=',')
    np.savetxt(MODEL_MOVIE_FACTORS_PATH, movie_factors, delimiter=',')

    # Zapisz mapowania do pliku JSON
    model_mappings = {
        'user_id_to_index': user_id_to_index,
        'movie_id_to_index': movie_id_to_index,
        'index_to_movie_id': index_to_movie_id
    }
    with open(MODEL_MAPPINGS_PATH, 'w') as f:
        json.dump(model_mappings, f)

    # Reset licznika nowych ocen
    reset_new_ratings_count()

    print("Model został zapisany do plików CSV i JSON.")

def load_matrix_factorization_model():
    """
    Ładuje model filtracji kolaboratywnej z plików CSV i JSON.
    Jeśli pliki nie istnieją, trenuje model.
    Zwraca słownik zawierający wektory użytkowników i filmów oraz mapowania ID do indeksów.
    """
    if not (os.path.exists(MODEL_USER_FACTORS_PATH) and
            os.path.exists(MODEL_MOVIE_FACTORS_PATH) and
            os.path.exists(MODEL_MAPPINGS_PATH)):
        print("Model nie istnieje. Rozpoczynam trening.")
        train_matrix_factorization_model()

    # Załaduj wektory czynników z plików CSV
    user_factors = np.loadtxt(MODEL_USER_FACTORS_PATH, delimiter=',')
    movie_factors = np.loadtxt(MODEL_MOVIE_FACTORS_PATH, delimiter=',')

    # Załaduj mapowania z pliku JSON
    with open(MODEL_MAPPINGS_PATH, 'r') as f:
        model_mappings = json.load(f)
    user_id_to_index = {int(k): int(v) for k, v in model_mappings['user_id_to_index'].items()}
    movie_id_to_index = {int(k): int(v) for k, v in model_mappings['movie_id_to_index'].items()}
    index_to_movie_id = {int(k): int(v) for k, v in model_mappings['index_to_movie_id'].items()}

    model_data = {
        'user_factors': user_factors,
        'movie_factors': movie_factors,
        'user_id_to_index': user_id_to_index,
        'movie_id_to_index': movie_id_to_index,
        'index_to_movie_id': index_to_movie_id
    }
    return model_data

def matrix_factorization_recommendation(user_id):
    """
    Generuje rekomendacje dla zalogowanego użytkownika na podstawie filtracji kolaboratywnej.
    Zwraca listę obiektów Movie.
    """
    try:
        model_data = load_matrix_factorization_model()
        user_factors = model_data['user_factors']
        movie_factors = model_data['movie_factors']
        user_id_to_index = model_data['user_id_to_index']
        movie_id_to_index = model_data['movie_id_to_index']
        index_to_movie_id = model_data['index_to_movie_id']

        if user_id not in user_id_to_index:
            # Użytkownik nie ma żadnych ocen
            return []

        user_idx = user_id_to_index[user_id]
        user_vector = user_factors[user_idx]

        # Oblicz przewidywane oceny dla wszystkich filmów
        scores = np.dot(movie_factors, user_vector)

        # Filmy już ocenione przez użytkownika
        user_ratings = Rating.objects.filter(user_id=user_id)
        rated_movie_ids = set([rating.movie_id for rating in user_ratings])

        # Posortuj filmy według przewidywanych ocen
        recommendations = []
        for idx in np.argsort(scores)[::-1]:
            movie_id = index_to_movie_id[idx]
            if movie_id not in rated_movie_ids:
                movie = Movie.objects.get(id=movie_id)
                recommendations.append(movie)
            if len(recommendations) >= 5:
                break

        return recommendations

    except Exception as e:
        print("Wystąpił błąd podczas generowania rekomendacji:", e)
        return []

def content_based_recommendation(user_id):
    """
    Generuje rekomendacje dla zalogowanego użytkownika na podstawie treści filmów i jego ocen.
    Zwraca listę obiektów Movie.
    """
    try:
        # Pobierz oceny użytkownika
        user_ratings = Rating.objects.filter(user_id=user_id)
        if not user_ratings.exists():
            return []

        # Tworzenie profilu użytkownika
        rated_movies = Movie.objects.filter(rating__user_id=user_id)
        rated_movies_df = pd.DataFrame(list(rated_movies.values('id', 'title', 'description')))

        # Przygotuj dane o wszystkich filmach
        all_movies = Movie.objects.all()
        all_movies_df = pd.DataFrame(list(all_movies.values('id', 'title', 'description')))

        # Dodaj kolumnę z cechami (gatunki, słowa kluczowe, obsada, reżyserzy)
        all_movies_df['features'] = all_movies_df['id'].apply(
            lambda x: get_movie_features(Movie.objects.get(id=x))
        )

        # Przygotuj macierz TF-IDF
        tfidf = TfidfVectorizer(stop_words='english')
        tfidf_matrix = tfidf.fit_transform(all_movies_df['features'])

        # Oblicz wektor profilu użytkownika
        user_profile = np.zeros(tfidf_matrix.shape[1])
        for rating in user_ratings:
            movie = Movie.objects.get(id=rating.movie_id)
            idx = all_movies_df[all_movies_df['id'] == movie.id].index[0]
            user_profile += tfidf_matrix[idx].toarray().flatten() * rating.score

        # Oblicz podobieństwo kosinusowe między profilem użytkownika a wszystkimi filmami
        cosine_similarities = linear_kernel(user_profile.reshape(1, -1), tfidf_matrix).flatten()

        # Filmy już ocenione przez użytkownika
        rated_movie_ids = set(user_ratings.values_list('movie_id', flat=True))

        # Posortuj filmy według podobieństwa
        similar_indices = cosine_similarities.argsort()[::-1]
        recommendations = []
        for idx in similar_indices:
            movie_id = all_movies_df.iloc[idx]['id']
            if movie_id not in rated_movie_ids:
                movie = Movie.objects.get(id=movie_id)
                recommendations.append(movie)
            if len(recommendations) >= 5:
                break

        return recommendations

    except Exception as e:
        print("Wystąpił błąd podczas generowania rekomendacji opartych na treści:", e)
        return []

def recommend_movies(user_id):
    """
    Generuje hybrydowe rekomendacje dla zalogowanego użytkownika, łącząc filtrację kolaboratywną i rekomendacje oparte na treści.
    Nadaje im odpowiednie wagi i zwraca listę obiektów Movie.
    """
    # Rekomendacje z filtracji kolaboratywnej
    collaborative_recommendations = matrix_factorization_recommendation(user_id)

    # Rekomendacje oparte na treści
    content_recommendations = content_based_recommendation(user_id)

    # Połącz rekomendacje, nadając im wagi
    recommendation_scores = {}

    # Ustal wagi
    weight_collaborative = 0.5
    weight_content = 0.5

    # Przetwórz rekomendacje z filtracji kolaboratywnej
    for idx, movie in enumerate(collaborative_recommendations):
        score = (len(collaborative_recommendations) - idx) * weight_collaborative
        recommendation_scores[movie.id] = recommendation_scores.get(movie.id, 0) + score

    # Przetwórz rekomendacje oparte na treści
    for idx, movie in enumerate(content_recommendations):
        score = (len(content_recommendations) - idx) * weight_content
        recommendation_scores[movie.id] = recommendation_scores.get(movie.id, 0) + score

    # Posortuj filmy według skumulowanego wyniku
    sorted_movie_ids = sorted(recommendation_scores, key=recommendation_scores.get, reverse=True)

    # Pobierz obiekty Movie
    recommendations = [Movie.objects.get(id=movie_id) for movie_id in sorted_movie_ids[:5]]

    return recommendations

# -------------------------- #
#   Funkcje Pomocnicze      #
# -------------------------- #

def get_new_ratings_count():
    """
    Zwraca liczbę nowych ocen od ostatniego retrenowania modelu.
    """
    if os.path.exists(MODEL_NEW_RATINGS_COUNT_PATH):
        with open(MODEL_NEW_RATINGS_COUNT_PATH, 'r') as f:
            try:
                count = int(f.read())
                return count
            except ValueError:
                return 0
    else:
        return 0

def increment_new_ratings_count():
    """
    Inkrementuje licznik nowych ocen i zapisuje go do pliku.
    Zwraca zaktualizowaną wartość.
    """
    count = get_new_ratings_count() + 1
    with open(MODEL_NEW_RATINGS_COUNT_PATH, 'w') as f:
        f.write(str(count))
    return count

def reset_new_ratings_count():
    """
    Resetuje licznik nowych ocen do zera.
    """
    with open(MODEL_NEW_RATINGS_COUNT_PATH, 'w') as f:
        f.write('0')

def update_model_with_new_rating(user_id, movie_id, rating):
    """
    Aktualizuje model rekomendacji na podstawie nowej oceny użytkownika.
    Inkrementuje licznik nowych ocen i trenuje model ponownie, jeśli próg został osiągnięty.
    """
    # Inkrementuj licznik nowych ocen
    new_ratings_count = increment_new_ratings_count()

    # Załaduj istniejący model
    model_data = load_matrix_factorization_model()
    user_factors = model_data['user_factors']
    movie_factors = model_data['movie_factors']
    user_id_to_index = model_data['user_id_to_index']
    movie_id_to_index = model_data['movie_id_to_index']
    index_to_movie_id = model_data['index_to_movie_id']

    # Jeśli nowy użytkownik lub film, rozszerz macierze i mapowania
    if user_id not in user_id_to_index:
        new_user_idx = len(user_id_to_index)
        user_id_to_index[user_id] = new_user_idx
        user_factors = np.vstack([
            user_factors,
            np.random.normal(scale=1./LATENT_FEATURES, size=(1, LATENT_FEATURES))
        ])

    if movie_id not in movie_id_to_index:
        new_movie_idx = len(movie_id_to_index)
        movie_id_to_index[movie_id] = new_movie_idx
        index_to_movie_id[new_movie_idx] = movie_id
        movie_factors = np.vstack([
            movie_factors,
            np.random.normal(scale=1./LATENT_FEATURES, size=(1, LATENT_FEATURES))
        ])

    user_idx = user_id_to_index[user_id]
    movie_idx = movie_id_to_index[movie_id]

    # Aktualizacja modelu przy użyciu nowej oceny
    prediction = np.dot(user_factors[user_idx], movie_factors[movie_idx])
    error = rating - prediction

    user_factors[user_idx] += LEARNING_RATE * (
        error * movie_factors[movie_idx] - REGULARIZATION * user_factors[user_idx]
    )
    movie_factors[movie_idx] += LEARNING_RATE * (
        error * user_factors[user_idx] - REGULARIZATION * movie_factors[movie_idx]
    )

    # Zapisz zaktualizowane wektory czynników do plików CSV
    np.savetxt(MODEL_USER_FACTORS_PATH, user_factors, delimiter=',')
    np.savetxt(MODEL_MOVIE_FACTORS_PATH, movie_factors, delimiter=',')

    # Zapisz zaktualizowane mapowania do pliku JSON
    model_mappings = {
        'user_id_to_index': user_id_to_index,
        'movie_id_to_index': movie_id_to_index,
        'index_to_movie_id': index_to_movie_id
    }
    with open(MODEL_MAPPINGS_PATH, 'w') as f:
        json.dump(model_mappings, f)

    print(f"Model został zaktualizowany z nową oceną: User ID={user_id}, Movie ID={movie_id}, Rating={rating}")

    # Sprawdź, czy osiągnięto próg nowych ocen do retrenowania
    if new_ratings_count >= NEW_RATINGS_THRESHOLD:
        print(f"Osiągnięto {NEW_RATINGS_THRESHOLD} nowych ocen. Rozpoczynam retrenowanie modelu.")
        train_matrix_factorization_model()
    else:
        print(f"Liczba nowych ocen: {new_ratings_count}/{NEW_RATINGS_THRESHOLD}")

def update_model_with_new_recommendation_feedback(user_id, movie_ids, score):
    """
    Aktualizuje model rekomendacji na podstawie oceny całej rekomendacji.
    """
    # Przypisujemy ocenę do każdego filmu w rekomendacji
    for movie_id in movie_ids:
        # Jeśli użytkownik jest zalogowany, przypisujemy ocenę do jego profilu
        if user_id:
            rating, created = Rating.objects.update_or_create(
                user_id=user_id,
                movie_id=movie_id,
                defaults={'score': score}
            )
            update_model_with_new_rating(user_id, movie_id, score)
        else:
            # Dla niezalogowanych użytkowników możemy przypisać ocenę anonimową
            anonymous_user, _ = User.objects.get_or_create(username='Anonymous', defaults={'password': 'anonymous'})
            rating, created = Rating.objects.update_or_create(
                user=anonymous_user,
                movie_id=movie_id,
                defaults={'score': score}
            )
            update_model_with_new_rating(anonymous_user.id, movie_id, score)

# -------------------------- #
#    Funkcje Zarządzania     #
# -------------------------- #

def reset_model():
    """
    Usuwa pliki modelu i resetuje liczniki.
    """
    for file_path in [MODEL_USER_FACTORS_PATH, MODEL_MOVIE_FACTORS_PATH, MODEL_MAPPINGS_PATH, MODEL_NEW_RATINGS_COUNT_PATH]:
        if os.path.exists(file_path):
            os.remove(file_path)
    print("Model oraz liczniki zostały zresetowane.")

def get_top_rated_movies(n=5):
    """
    Zwraca listę top n najlepiej ocenianych filmów na podstawie średniej oceny.
    """
    top_movies = Movie.objects.annotate(avg_rating=Avg('rating__score')).order_by('-avg_rating')[:n]
    return top_movies

def get_newest_movies(n=5):
    """
    Zwraca listę n najnowszych filmów na podstawie roku wydania.
    """
    newest_movies = Movie.objects.all().order_by('-release_year')[:n]
    return newest_movies

def get_most_rated_movies(n=5):
    """
    Zwraca listę n filmów z największą liczbą ocen.
    """
    most_rated_movies = Movie.objects.annotate(rating_count=Count('rating')).order_by('-rating_count')[:n]
    return most_rated_movies
