import os
import django
import tmdbsimple as tmdb
from random import randint
from django.db import transaction
from django.utils import timezone

# Ustawienia Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'MovieRecommender.settings')
django.setup()

from movies.models import Movie, Genre, Director, CastMember, Keyword, Rating
from django.contrib.auth.models import User

# Ustaw klucz API TMDb
tmdb.API_KEY = '04756ff411b2385e80a1f086c0bb27ee'  # Zastąp swoim kluczem API

def populate_users():
    existing_users = User.objects.all().count()
    if existing_users < 20:
        for i in range(existing_users + 1, 21):
            username = f'user{i}'
            User.objects.create_user(username=username, password='password123')
            print(f"Utworzono użytkownika: {username}")
    else:
        print("Użytkownicy już istnieją.")

def populate_movies():
    movie_ids = set()
    total_movies_needed = 200

    page = 1
    while len(movie_ids) < total_movies_needed:
        print(f"Pobieranie strony {page} popularnych filmów...")
        popular = tmdb.Movies().popular(page=page)
        for movie_data in popular['results']:
            movie_ids.add(movie_data['id'])
            if len(movie_ids) >= total_movies_needed:
                break
        page += 1
        if page > 500:
            break  # Ograniczenie do 500 stron, aby uniknąć przekroczenia limitów API

    for movie_id in movie_ids:
        try:
            with transaction.atomic():
                # Pobieranie informacji o filmie
                movie = tmdb.Movies(movie_id)
                movie_info = movie.info(language='en-US')
                movie_credits = movie.credits()
                movie_keywords = movie.keywords()

                # Sprawdź, czy film już istnieje w bazie danych
                release_year = int(movie_info['release_date'][:4]) if movie_info.get('release_date') else None
                if Movie.objects.filter(title=movie_info['title'], release_year=release_year).exists():
                    continue

                # Tworzenie filmu
                movie_obj = Movie.objects.create(
                    title=movie_info['title'],
                    release_year=release_year,
                    description=movie_info.get('overview', ''),
                    poster_url=f"https://image.tmdb.org/t/p/w500{movie_info['poster_path']}" if movie_info.get('poster_path') else ''
                )

                # Gatunki
                for genre_data in movie_info['genres']:
                    genre_obj, _ = Genre.objects.get_or_create(name=genre_data['name'])
                    movie_obj.genres.add(genre_obj)

                # Reżyserzy
                for crew_member in movie_credits['crew']:
                    if crew_member['job'] == 'Director':
                        director_obj, _ = Director.objects.get_or_create(name=crew_member['name'])
                        movie_obj.directors.add(director_obj)

                # Obsada
                for cast_member in movie_credits['cast'][:5]:  # Ograniczamy do 5 aktorów
                    cast_obj, _ = CastMember.objects.get_or_create(name=cast_member['name'])
                    movie_obj.cast.add(cast_obj)

                # Słowa kluczowe
                for keyword_data in movie_keywords['keywords']:
                    keyword_obj, _ = Keyword.objects.get_or_create(name=keyword_data['name'])
                    movie_obj.keywords.add(keyword_obj)

                movie_obj.save()
                print(f"Dodano film: {movie_obj.title}")

        except Exception as e:
            print(f"Błąd przy dodawaniu filmu ID {movie_id}: {e}")

def add_ratings():
    users = User.objects.all()
    movies = Movie.objects.all()

    for user in users:
        rated_movies = movies.order_by('?')[:randint(5, 15)]  # Each user rates 5 to 15 movies
        for movie in rated_movies:
            score = randint(1, 10)
            Rating.objects.create(
                user=user,
                movie=movie,
                score=score,
                comment=''  # timestamp is set automatically
            )
        print(f"User {user.username} rated movies.")


if __name__ == '__main__':
    populate_users()
    populate_movies()
    add_ratings()
