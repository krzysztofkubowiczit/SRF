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
from django.db.models import Avg
import numpy as np
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.neighbors import NearestNeighbors

# Funkcje rekomendacji
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
            'description': movie.description if movie.description else '',
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

    # Sprawdź, czy mamy wystarczającą liczbę filmów
    if count_matrix.shape[0] < 2:
        print("Za mało filmów w bazie danych do wygenerowania rekomendacji.")
        return []

    # Dopasowanie modelu KNN
    knn = NearestNeighbors(metric='cosine', algorithm='brute')
    knn.fit(count_matrix)

    # Wybierz losowy film jako punkt odniesienia
    random_movie_idx = np.random.choice(count_matrix.shape[0])
    distances, indices = knn.kneighbors(count_matrix[random_movie_idx], n_neighbors=6)

    recommended_movies = []
    for i in indices.flatten()[1:]:  # Pomijamy pierwszy indeks, który jest samym filmem
        movie_id = df.iloc[i]['id']
        movie = Movie.objects.get(id=movie_id)
        recommended_movies.append(movie)

    return recommended_movies  # Zwracamy listę obiektów Movie

def matrix_factorization_recommendation(user_id):
    try:
        # Pobierz oceny użytkowników
        ratings = Rating.objects.all()
        if not ratings.exists():
            print("Brak ocen w bazie danych.")
            return []

        ratings_df = pd.DataFrame(list(ratings.values('user_id', 'movie_id', 'score')))

        # Pivot table
        user_movie_matrix = ratings_df.pivot_table(index='user_id', columns='movie_id', values='score').fillna(0)

        # Konwersja do macierzy
        matrix = user_movie_matrix.values
        user_ids = list(user_movie_matrix.index)
        movie_ids = list(user_movie_matrix.columns)

        # Sprawdź, czy użytkownik istnieje w macierzy
        if user_id not in user_ids:
            print("Użytkownik nie ma żadnych ocen. Nie można wygenerować rekomendacji.")
            return []

        # Średnia ocen
        user_ratings_mean = np.mean(matrix, axis=1)
        R_demeaned = matrix - user_ratings_mean.reshape(-1, 1)

        # SVD
        from scipy.sparse.linalg import svds
        k = min(50, min(R_demeaned.shape) - 1)  # Upewnij się, że k nie przekracza wymiarów macierzy
        U, sigma, Vt = svds(R_demeaned, k=k)
        sigma = np.diag(sigma)

        # Rekonstrukcja macierzy
        all_user_predicted_ratings = np.dot(np.dot(U, sigma), Vt) + user_ratings_mean.reshape(-1, 1)
        preds_df = pd.DataFrame(all_user_predicted_ratings, index=user_ids, columns=movie_ids)

        # Pobierz oceny użytkownika
        user_row_number = user_ids.index(user_id)
        sorted_user_predictions = preds_df.iloc[user_row_number].sort_values(ascending=False)

        # Filmy ocenione przez użytkownika
        user_data = ratings_df[ratings_df.user_id == user_id]
        user_history = user_data['movie_id'].tolist()

        # Filmy jeszcze nie ocenione przez użytkownika
        recommendations = []
        for movie_id in sorted_user_predictions.index:
            if movie_id not in user_history:
                movie = Movie.objects.get(id=movie_id)
                recommendations.append(movie)
            if len(recommendations) >= 5:
                break

        if not recommendations:
            print("Brak rekomendacji dla tego użytkownika.")
            return []

        return recommendations  # Zwracamy listę obiektów Movie

    except Exception as e:
        print("Wystąpił błąd podczas generowania rekomendacji:", e)
        return []

# Nowe funkcje dla opcji menu
def recommend_movies_for_new_user():
    recommendations = knn_recommendation()
    if recommendations:
        print("Rekomendacje dla nowego użytkownika:")
        for movie in recommendations:
            print(f"- {movie.title}")
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

def recommend_movies_for_user(user):
    recommendations = matrix_factorization_recommendation(user.id)
    if recommendations:
        print(f"Rekomendacje dla {user.username}:")
        for movie in recommendations:
            print(f"- {movie.title}")
    else:
        print(f"Brak rekomendacji dla użytkownika {user.username}.")

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
        for idx, movie in enumerate(movies, start=1):
            print(f"{idx}. {movie.title} ({movie.release_year})")
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
    # Wyświetl informacje o filmie
    print(f"Tytuł: {movie.title}")
    print(f"Rok wydania: {movie.release_year}")
    print(f"Opis: {movie.description}")
    print("Gatunki:", ", ".join([genre.name for genre in movie.genres.all()]))
    print("Słowa kluczowe:", ", ".join([keyword.name for keyword in movie.keywords.all()]))
    print("Obsada:", ", ".join([cast_member.name for cast_member in movie.cast.all()]))
    print("Reżyserzy:", ", ".join([director.name for director in movie.directors.all()]))
    # Wyświetl oceny
    ratings = Rating.objects.filter(movie=movie)
    if ratings.exists():
        avg_rating = ratings.aggregate(Avg('score'))['score__avg']
        print(f"Średnia ocena: {avg_rating:.2f}")
    else:
        print("Brak ocen dla tego filmu.")

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

def main():
    while True:
        print("\n--- Menu ---")
        print("1. Zarekomenduj 5 filmów dla nowego użytkownika")
        print("2. Zaloguj się jako użytkownik")
        print("3. Pokaż dane filmu")
        print("4. Koniec")
        choice = input("Wybierz opcję (1-4): ")

        if choice == '1':
            recommend_movies_for_new_user()
        elif choice == '2':
            user = select_user()
            if user:
                user_menu(user)
        elif choice == '3':
            show_movie_data()
        elif choice == '4':
            print("Do widzenia!")
            break
        else:
            print("Nieprawidłowy wybór. Spróbuj ponownie.")

if __name__ == '__main__':
    main()
