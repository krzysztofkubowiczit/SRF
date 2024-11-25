import os
import sys
import django

# Ścieżki
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))  # .../MovieRecommender/movies
PARENT_DIR = os.path.dirname(CURRENT_DIR)                 # .../MovieRecommender

# Dodaj PARENT_DIR do sys.path
sys.path.insert(0, PARENT_DIR)

# Ustawienia Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'MovieRecommender.settings')
django.setup()

# Importy
from movies.models import Movie, Genre, Keyword, Rating, FavoriteMovie
from django.contrib.auth.models import User
from django.db.models import Avg, Count
import numpy as np
import pandas as pd
import csv
import json  # Do zapisu mapowań w formacie JSON
from sklearn.metrics.pairwise import cosine_similarity, linear_kernel
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.neighbors import NearestNeighbors

# Ścieżki do plików modelu
MODEL_USER_FACTORS_PATH = os.path.join(CURRENT_DIR, 'user_factors.csv')
MODEL_MOVIE_FACTORS_PATH = os.path.join(CURRENT_DIR, 'movie_factors.csv')
MODEL_MAPPINGS_PATH = os.path.join(CURRENT_DIR, 'model_mappings.json')
MODEL_NEW_RATINGS_COUNT_PATH = os.path.join(CURRENT_DIR, 'new_ratings_count.txt')

# Parametry modelu
LATENT_FEATURES = 10
LEARNING_RATE = 0.01
REGULARIZATION = 0.1
EPOCHS = 20

# Licznik nowych ocen od ostatniego retrenowania
NEW_RATINGS_THRESHOLD = 50

# Funkcje do zarządzania licznikiem nowych ocen
def get_new_ratings_count():
    if os.path.exists(MODEL_NEW_RATINGS_COUNT_PATH):
        with open(MODEL_NEW_RATINGS_COUNT_PATH, 'r') as f:
            count = int(f.read())
            return count
    else:
        return 0

def increment_new_ratings_count():
    count = get_new_ratings_count() + 1
    with open(MODEL_NEW_RATINGS_COUNT_PATH, 'w') as f:
        f.write(str(count))
    return count

def reset_new_ratings_count():
    with open(MODEL_NEW_RATINGS_COUNT_PATH, 'w') as f:
        f.write('0')

# Funkcje rekomendacji
def get_movie_features(movie):
    genres = ' '.join([genre.name for genre in movie.genres.all()])
    keywords = ' '.join([keyword.name for keyword in movie.keywords.all()])
    cast = ' '.join([member.name for member in movie.cast.all()])
    directors = ' '.join([director.name for director in movie.directors.all()])
    return f"{genres} {keywords} {cast} {directors}"

def knn_recommendation():
    all_movies = Movie.objects.all()
    if not all_movies.exists():
        print("Brak filmów w bazie danych.")
        return []

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
    distances, indices = knn.kneighbors(tfidf_matrix[random_idx], n_neighbors=6)
    recommendations = []
    for idx in indices.flatten():
        if idx != random_idx:
            movie_id = movies_df.iloc[idx]['id']
            movie = Movie.objects.get(id=movie_id)
            recommendations.append(movie)
    return recommendations

def train_matrix_factorization_model():
    # Pobierz oceny użytkowników
    ratings = Rating.objects.all()
    if not ratings.exists():
        print("Brak ocen w bazie danych.")
        return None

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

    print("Model został zapisany do plików CSV i JSON.")
    reset_new_ratings_count()  # Reset licznika nowych ocen

def load_matrix_factorization_model():
    if not os.path.exists(MODEL_USER_FACTORS_PATH) or not os.path.exists(MODEL_MOVIE_FACTORS_PATH) or not os.path.exists(MODEL_MAPPINGS_PATH):
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
    try:
        model_data = load_matrix_factorization_model()
        user_factors = model_data['user_factors']
        movie_factors = model_data['movie_factors']
        user_id_to_index = model_data['user_id_to_index']
        movie_id_to_index = model_data['movie_id_to_index']
        index_to_movie_id = model_data['index_to_movie_id']

        if user_id not in user_id_to_index:
            print("Użytkownik nie ma żadnych ocen.")
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

        if not recommendations:
            print("Brak rekomendacji dla tego użytkownika.")
            return []

        return recommendations

    except Exception as e:
        print("Wystąpił błąd podczas generowania rekomendacji:", e)
        return []

def update_model_with_new_rating(user_id, movie_id, rating):
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

    print("Model został zaktualizowany i zapisany.")

    # Sprawdź, czy osiągnięto próg nowych ocen do retrenowania
    if new_ratings_count >= NEW_RATINGS_THRESHOLD:
        print(f"Osiągnięto {NEW_RATINGS_THRESHOLD} nowych ocen. Retrenowanie modelu...")
        train_matrix_factorization_model()

def content_based_recommendation(user_id):
    try:
        # Pobierz oceny użytkownika
        user_ratings = Rating.objects.filter(user_id=user_id)
        if not user_ratings.exists():
            print("Użytkownik nie ma żadnych ocen.")
            return []

        # Tworzenie profilu użytkownika
        # Zbierz informacje o filmach ocenionych przez użytkownika
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

        if not recommendations:
            print("Brak rekomendacji opartych na treści dla tego użytkownika.")
            return []

        return recommendations

    except Exception as e:
        print("Wystąpił błąd podczas generowania rekomendacji opartych na treści:", e)
        return []

def recommend_movies_for_user(user):
    # Rekomendacje z filtracji kolaboratywnej
    collaborative_recommendations = matrix_factorization_recommendation(user.id)

    # Rekomendacje oparte na treści
    content_recommendations = content_based_recommendation(user.id)

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

    if recommendations:
        print(f"Rekomendacje dla {user.username}:")
        for idx, movie in enumerate(recommendations, start=1):
            print(f"{idx}. {movie.title}")
        # Zapytaj użytkownika, czy chce ocenić rekomendacje
        print("\nCzy chciałbyś ocenić któreś z powyższych filmów? Twoje oceny pomogą nam w lepszym dopasowywaniu filmów w przyszłości.")
        rate_choice = input("Wpisz 'tak' aby ocenić filmy lub naciśnij Enter aby kontynuować: ").lower()
        if rate_choice == 'tak':
            rate_recommendations(user, recommendations)
    else:
        print(f"Brak rekomendacji dla użytkownika {user.username}.")

def rate_recommendations(user, recommendations):
    for movie in recommendations:
        while True:
            rate = input(f"Czy chciałbyś ocenić film '{movie.title}'? (tak/pomiń): ").lower()
            if rate == 'tak':
                score = input("Podaj ocenę filmu (1-10): ")
                try:
                    score = int(score)
                    if 1 <= score <= 10:
                        # Zapisz ocenę w tabeli Rating
                        rating, created = Rating.objects.update_or_create(
                            user=user, movie=movie,
                            defaults={'score': score, 'comment': 'Ocena rekomendacji'}
                        )
                        # Aktualizuj model
                        update_model_with_new_rating(user.id, movie.id, score)
                        print(f"Dziękujemy za ocenę filmu '{movie.title}'.")
                        break
                    else:
                        print("Ocena musi być w przedziale 1-10.")
                except ValueError:
                    print("Ocena musi być liczbą całkowitą.")
            elif rate == 'pomiń' or rate == '':
                print(f"Pominięto ocenę filmu '{movie.title}'.")
                break
            else:
                print("Nie zrozumiałem odpowiedzi. Proszę wpisać 'tak' lub 'pomiń'.")

# Pozostałe funkcje
def recommend_movies_for_new_user():
    recommendations = knn_recommendation()
    if recommendations:
        print("Rekomendacje dla nowego użytkownika:")
        for idx, movie in enumerate(recommendations, start=1):
            print(f"{idx}. {movie.title}")
    else:
        print("Brak rekomendacji dla nowego użytkownika.")

def select_user():
    username = input("Podaj nazwę użytkownika: ")
    try:
        user = User.objects.get(username=username)
        print(f"Zalogowano jako: {user.username}")
        return user
    except User.DoesNotExist:
        print("Użytkownik nie istnieje.")
        return None

def show_movie_data():
    movie_title = input("Podaj tytuł filmu: ")
    movies = Movie.objects.filter(title=movie_title)
    if not movies.exists():
        print("Film nie został znaleziony.")
        return
    elif movies.count() == 1:
        movie = movies.first()
    else:
        print("Znaleziono kilka filmów o tym tytule:")
        for idx, m in enumerate(movies, start=1):
            print(f"{idx}. {m.title} ({m.release_year})")
        choice = input("Wybierz numer filmu: ")
        try:
            movie_idx = int(choice) - 1
            if 0 <= movie_idx < movies.count():
                movie = movies[movie_idx]
            else:
                print("Nieprawidłowy wybór.")
                return
        except ValueError:
            print("Nieprawidłowy wybór.")
            return
    print(f"Tytuł: {movie.title}")
    print(f"Rok wydania: {movie.release_year}")
    print(f"Opis: {movie.description}")
    print(f"Gatunki: {', '.join([genre.name for genre in movie.genres.all()])}")
    print(f"Słowa kluczowe: {', '.join([keyword.name for keyword in movie.keywords.all()])}")
    print(f"Obsada: {', '.join([member.name for member in movie.cast.all()])}")
    print(f"Reżyserzy: {', '.join([director.name for director in movie.directors.all()])}")

def add_movie_to_favorites(user):
    movie_title = input("Podaj tytuł filmu do dodania do ulubionych: ")
    movies = Movie.objects.filter(title=movie_title)
    if not movies.exists():
        print("Film nie został znaleziony.")
        return
    elif movies.count() == 1:
        movie = movies.first()
    else:
        print("Znaleziono kilka filmów o tym tytule:")
        for idx, m in enumerate(movies, start=1):
            print(f"{idx}. {m.title} ({m.release_year})")
        choice = input("Wybierz numer filmu: ")
        try:
            movie_idx = int(choice) - 1
            if 0 <= movie_idx < movies.count():
                movie = movies[movie_idx]
            else:
                print("Nieprawidłowy wybór.")
                return
        except ValueError:
            print("Nieprawidłowy wybór.")
            return
    favorite, created = FavoriteMovie.objects.get_or_create(user=user, movie=movie)
    if created:
        print(f"Film '{movie.title}' został dodany do ulubionych.")
        # Traktujemy dodanie do ulubionych jako pozytywną ocenę
        default_score = 8  # Możesz dostosować domyślną ocenę
        rating, created_rating = Rating.objects.update_or_create(
            user=user, movie=movie,
            defaults={'score': default_score, 'comment': 'Dodano do ulubionych'}
        )
        # Aktualizuj model
        update_model_with_new_rating(user.id, movie.id, default_score)
    else:
        print(f"Film '{movie.title}' jest już w ulubionych.")

def add_rating(user):
    movie_title = input("Podaj tytuł filmu do oceny: ")
    movies = Movie.objects.filter(title=movie_title)
    if not movies.exists():
        print("Film nie został znaleziony.")
        return
    elif movies.count() == 1:
        movie = movies.first()
    else:
        print("Znaleziono kilka filmów o tym tytule:")
        for idx, m in enumerate(movies, start=1):
            print(f"{idx}. {m.title} ({m.release_year})")
        choice = input("Wybierz numer filmu: ")
        try:
            movie_idx = int(choice) - 1
            if 0 <= movie_idx < movies.count():
                movie = movies[movie_idx]
            else:
                print("Nieprawidłowy wybór.")
                return
        except ValueError:
            print("Nieprawidłowy wybór.")
            return
    try:
        score = int(input("Podaj ocenę (1-10): "))
        if score < 1 or score > 10:
            print("Ocena musi być w przedziale 1-10.")
            return
    except ValueError:
        print("Ocena musi być liczbą całkowitą.")
        return
    comment = input("Dodaj komentarz (opcjonalnie): ")
    rating, created = Rating.objects.update_or_create(
        user=user, movie=movie,
        defaults={'score': score, 'comment': comment}
    )
    print(f"Ocena została {'dodana' if created else 'zaktualizowana'}.")

    # Aktualizuj model na podstawie nowej oceny
    update_model_with_new_rating(user.id, movie.id, score)

def show_user_favorites(user):
    favorites = FavoriteMovie.objects.filter(user=user)
    if favorites.exists():
        print(f"Ulubione filmy użytkownika {user.username}:")
        for favorite in favorites:
            print(f"- {favorite.movie.title}")
    else:
        print(f"Użytkownik {user.username} nie ma żadnych ulubionych filmów.")

def show_user_ratings(user):
    ratings = Rating.objects.filter(user=user)
    if ratings.exists():
        print(f"Oceny przesłane przez użytkownika {user.username}:")
        for rating in ratings:
            print(f"- {rating.movie.title}: {rating.score}/10")
            if rating.comment:
                print(f"  Komentarz: {rating.comment}")
    else:
        print(f"Użytkownik {user.username} nie dodał żadnych ocen.")

def user_menu(user):
    while True:
        print(f"\n--- Menu użytkownika: {user.username} ---")
        print("1. Zarekomenduj filmy dla użytkownika")
        print("2. Pokaż ulubione filmy użytkownika")
        print("3. Pokaż oceny przesłane przez użytkownika")
        print("4. Dodaj film do ulubionych")
        print("5. Dodaj ocenę")
        print("6. Wyloguj")
        choice = input("Wybierz opcję (1-6): ")

        if choice == '1':
            recommend_movies_for_user(user)
        elif choice == '2':
            show_user_favorites(user)
        elif choice == '3':
            show_user_ratings(user)
        elif choice == '4':
            add_movie_to_favorites(user)
        elif choice == '5':
            add_rating(user)
        elif choice == '6':
            print(f"Wylogowano użytkownika {user.username}")
            break
        else:
            print("Nieprawidłowy wybór. Spróbuj ponownie.")

def show_newest_movies():
    movies = Movie.objects.all().order_by('-release_year')[:5]
    if movies:
        print("5 najnowszych filmów:")
        for movie in movies:
            print(f"- {movie.title} ({movie.release_year})")
    else:
        print("Brak filmów w bazie danych.")

def show_top_rated_movies():
    movies = Movie.objects.annotate(avg_rating=Avg('rating__score')).order_by('-avg_rating')[:5]
    if movies:
        print("5 filmów z najlepszą średnią ocen:")
        for movie in movies:
            avg_rating = movie.avg_rating if movie.avg_rating else 0
            print(f"- {movie.title} - Średnia ocena: {avg_rating:.2f}")
    else:
        print("Brak ocenionych filmów w bazie danych.")

def show_most_rated_movies():
    movies = Movie.objects.annotate(rating_count=Count('rating')).order_by('-rating_count')[:5]
    if movies:
        print("5 filmów z największą liczbą ocen:")
        for movie in movies:
            print(f"- {movie.title} - Liczba ocen: {movie.rating_count}")
    else:
        print("Brak ocenionych filmów w bazie danych.")

def main():
    while True:
        print("\n--- Menu ---")
        print("1. Zarekomenduj 5 filmów dla nowego użytkownika")
        print("2. Pokaż 5 najnowszych filmów")
        print("3. Pokaż 5 filmów z najlepszą średnią ocen")
        print("4. Pokaż 5 filmów z największą liczbą ocen")
        print("5. Zaloguj się jako użytkownik")
        print("6. Pokaż dane filmu")
        print("7. Koniec")
        choice = input("Wybierz opcję (1-7): ")

        if choice == '1':
            recommend_movies_for_new_user()
        elif choice == '2':
            show_newest_movies()
        elif choice == '3':
            show_top_rated_movies()
        elif choice == '4':
            show_most_rated_movies()
        elif choice == '5':
            user = select_user()
            if user:
                user_menu(user)
        elif choice == '6':
            show_movie_data()
        elif choice == '7':
            print("Do widzenia!")
            break
        else:
            print("Nieprawidłowy wybór. Spróbuj ponownie.")

if __name__ == '__main__':
    main()
