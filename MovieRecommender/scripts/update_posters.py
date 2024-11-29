# scripts/update_posters.py

import os
import sys
import django
import tmdbsimple as tmdb
from dotenv import load_dotenv
import argparse

# Załaduj zmienne środowiskowe z pliku .env (jeśli używasz)
load_dotenv()

# Dodaj główny katalog projektu do sys.path
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))  # scripts/
PROJECT_ROOT = os.path.dirname(SCRIPT_DIR)               # MovieRecommender/
sys.path.insert(0, PROJECT_ROOT)

# Ustawienia Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'MovieRecommender.settings')
django.setup()

# Import modelu Movie
try:
    from movies.models import Movie
except ImportError as e:
    print("Błąd importu modułu 'movies.models':", e)
    print("Upewnij się, że aplikacja 'movies' znajduje się w INSTALLED_APPS w pliku settings.py.")
    sys.exit(1)

# Ustaw swój klucz API
tmdb.API_KEY = os.environ.get('TMDB_API_KEY')
if not tmdb.API_KEY:
    raise Exception("Brak klucza API. Ustaw zmienną środowiskową TMDB_API_KEY.")

def get_movie_poster(title, release_year=None):
    search = tmdb.Search()
    query = {'query': title, 'language': 'en-US'}  # Możesz zmienić language na 'pl-PL' dla polskich tytułów
    if release_year:
        query['year'] = release_year
    response = search.movie(**query)
    if search.results:
        # Sprawdź, czy tytuł i rok wydania się zgadzają
        for result in search.results:
            result_title = result.get('title')
            result_release_date = result.get('release_date')
            result_year = int(result_release_date.split('-')[0]) if result_release_date else None
            if result_title.lower() == title.lower() or (release_year and result_year == release_year):
                poster_path = result.get('poster_path')
                if poster_path:
                    poster_url = f"https://image.tmdb.org/t/p/w500{poster_path}"
                    return poster_url
        # Jeśli nie znaleziono dokładnego dopasowania, zwróć pierwszy wynik
        poster_path = search.results[0].get('poster_path')
        if poster_path:
            poster_url = f"https://image.tmdb.org/t/p/w500{poster_path}"
            return poster_url
    return None

def update_movie_posters(force_update=False):
    movies = Movie.objects.all()
    for movie in movies:
        if not force_update and movie.poster_url:
            print(f"Plakat dla filmu '{movie.title}' już istnieje. Użyj --force, aby wymusić aktualizację.")
            continue  # Pomijamy ten film

        poster_url = get_movie_poster(movie.title, release_year=movie.release_year)
        if poster_url:
            movie.poster_url = poster_url
            movie.save()
            print(f"Zaktualizowano plakat dla filmu '{movie.title}'.")
        else:
            print(f"Nie znaleziono plakatu dla filmu '{movie.title}'.")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Aktualizacja plakatów filmów.")
    parser.add_argument('--force', action='store_true', help='Wymuś aktualizację plakatów, nawet jeśli już istnieją.')
    args = parser.parse_args()

    update_movie_posters(force_update=args.force)
