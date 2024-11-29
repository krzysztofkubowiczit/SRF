# movies/views.py

from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth import login, authenticate, logout, update_session_auth_hash
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import PasswordChangeForm
from django.db.models import Avg, Count
from django.contrib.auth.models import User
from .models import Movie, Rating, FavoriteMovie, RecommendationFeedback
from .forms import UserRegisterForm
from .recommendations import (
    knn_recommendation,
    recommend_movies,
    update_model_with_new_rating,
    update_model_with_new_recommendation_feedback,
)

# Widok strony głównej
def home(request):
    # Pobierz najnowsze, najlepiej oceniane i najczęściej oceniane filmy
    newest_movies = Movie.objects.all().order_by('-release_year')[:5]
    top_rated_movies = Movie.objects.annotate(avg_rating=Avg('rating__score')).order_by('-avg_rating')[:5]
    most_rated_movies = Movie.objects.annotate(rating_count=Count('rating')).order_by('-rating_count')[:5]

    context = {
        'newest_movies': newest_movies,
        'top_rated_movies': top_rated_movies,
        'most_rated_movies': most_rated_movies,
    }

    return render(request, 'home.html', context)

# Widok rejestracji użytkownika
def register(request):
    if request.method == 'POST':
        form = UserRegisterForm(request.POST)
        if form.is_valid():
            user = form.save()
            username = form.cleaned_data.get('username')
            messages.success(request, f'Utworzono konto dla użytkownika {username}. Możesz się teraz zalogować.')
            return redirect('login')
    else:
        form = UserRegisterForm()
    return render(request, 'register.html', {'form': form})

# Widok logowania użytkownika
def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('home')
        else:
            messages.error(request, 'Nieprawidłowa nazwa użytkownika lub hasło.')
    return render(request, 'login.html')

# Widok wylogowania użytkownika
def logout_view(request):
    logout(request)
    messages.success(request, 'Zostałeś wylogowany.')
    return redirect('home')

# Widok szczegółów filmu
def movie_detail(request, movie_id):
    movie = get_object_or_404(Movie, id=movie_id)
    ratings = Rating.objects.filter(movie=movie).order_by('-id')  # Najnowsze oceny na górze
    avg_rating = Rating.objects.filter(movie=movie).aggregate(avg=Avg('score'))['avg']
    context = {
        'movie': movie,
        'ratings': ratings,
        'avg_rating': avg_rating
    }
    return render(request, 'movie_detail.html', context)

# Widok rekomendacji dla gości (niezalogowanych użytkowników)
def guest_recommendations(request):
    if request.method == 'POST':
        score = request.POST.get('score')
        try:
            score = int(score)
            if 1 <= score <= 10:
                # Zapisz ocenę rekomendacji w modelu
                RecommendationFeedback.objects.create(
                    user=None,
                    recommendation=request.session.get('recommendation_ids', []),
                    score=score
                )
                messages.success(request, 'Dziękujemy za ocenę rekomendacji!')
                # Aktualizuj model rekomendacji
                update_model_with_new_recommendation_feedback(None, request.session.get('recommendation_ids', []), score)
                return redirect('home')
            else:
                messages.error(request, 'Ocena musi być w przedziale 1-10.')
        except ValueError:
            messages.error(request, 'Ocena musi być liczbą całkowitą.')
    else:
        recommendations = knn_recommendation()
        # Zapisz ID poleconych filmów w sesji
        request.session['recommendation_ids'] = [movie.id for movie in recommendations]
        return render(request, 'guest_recommendations.html', {'recommendations': recommendations})

# Widok rekomendacji dla zalogowanego użytkownika
@login_required
def user_recommendations(request):
    if request.method == 'POST':
        # Przetwarzanie oceny całej rekomendacji
        overall_score = request.POST.get('score')
        if overall_score:
            try:
                overall_score = int(overall_score)
                if 1 <= overall_score <= 10:
                    RecommendationFeedback.objects.create(
                        user=request.user,
                        recommendation=request.session.get('recommendation_ids', []),
                        score=overall_score
                    )
                    messages.success(request, 'Dziękujemy za ocenę rekomendacji!')
                    # Aktualizuj model rekomendacji
                    update_model_with_new_recommendation_feedback(request.user.id, request.session.get('recommendation_ids', []), overall_score)
                else:
                    messages.error(request, 'Ocena rekomendacji musi być w przedziale 1-10.')
            except ValueError:
                messages.error(request, 'Ocena rekomendacji musi być liczbą całkowitą.')

        # Przetwarzanie ocen indywidualnych i dodawania do ulubionych
        recommendation_ids = request.session.get('recommendation_ids', [])
        for movie_id in recommendation_ids:
            movie_id = int(movie_id)
            score_key = f'score_{movie_id}'
            comment_key = f'comment_{movie_id}'
            favorite_key = f'favorite_{movie_id}'

            score = request.POST.get(score_key)
            comment = request.POST.get(comment_key, '')
            is_favorite = favorite_key in request.POST

            # Obsługa ocen indywidualnych (opcjonalne)
            if score:
                try:
                    score = int(score)
                    if 1 <= score <= 10:
                        rating, created = Rating.objects.update_or_create(
                            user=request.user,
                            movie_id=movie_id,
                            defaults={'score': score, 'comment': comment}
                        )
                        # Aktualizuj model rekomendacji
                        update_model_with_new_rating(request.user.id, movie_id, score)
                except ValueError:
                    messages.error(request, f'Ocena dla filmu ID {movie_id} musi być liczbą całkowitą.')

            # Obsługa dodawania do ulubionych (niezależnie od oceny)
            if is_favorite:
                FavoriteMovie.objects.get_or_create(user=request.user, movie_id=movie_id)

        messages.success(request, 'Twoje oceny zostały zapisane.')
        return redirect('user_recommendations')

    else:
        # Generuj rekomendacje
        has_ratings = Rating.objects.filter(user=request.user).exists()
        if has_ratings:
            recommendations = recommend_movies(request.user.id)
        else:
            recommendations = knn_recommendation()
        request.session['recommendation_ids'] = [movie.id for movie in recommendations]
        context = {
            'recommendations': recommendations
        }
        return render(request, 'user_recommendations.html', context)

# Widok profilu użytkownika
@login_required
def user_profile(request):
    user = request.user
    password_form = PasswordChangeForm(user=user)

    if request.method == 'POST':
        if 'change_password' in request.POST:
            password_form = PasswordChangeForm(user=user, data=request.POST)
            if password_form.is_valid():
                user = password_form.save()
                update_session_auth_hash(request, user)  # Zachowanie sesji po zmianie hasła
                messages.success(request, 'Hasło zostało zmienione.')
                return redirect('user_profile')
            else:
                messages.error(request, 'Błąd przy zmianie hasła.')
        elif 'change_email' in request.POST:
            email = request.POST.get('email')
            if email and User.objects.filter(email=email).exclude(id=user.id).exists():
                messages.error(request, 'Ten adres email jest już używany.')
            elif email:
                user.email = email
                user.save()
                messages.success(request, 'Adres email został zaktualizowany.')
                return redirect('user_profile')
            else:
                messages.error(request, 'Adres email jest wymagany.')

    context = {
        'user': user,
        'password_form': password_form
    }
    return render(request, 'user_profile.html', context)

# Widok ulubionych filmów użytkownika
@login_required
def user_favorites(request):
    favorites = FavoriteMovie.objects.filter(user=request.user)
    return render(request, 'user_favorites.html', {'favorites': favorites})

# Widok ocen użytkownika
@login_required
def user_ratings(request):
    ratings = Rating.objects.filter(user=request.user)
    return render(request, 'user_ratings.html', {'ratings': ratings})

# Widok dodawania/aktualizacji oceny filmu przez użytkownika
@login_required
def add_rating(request, movie_id):
    movie = get_object_or_404(Movie, id=movie_id)
    if request.method == 'POST':
        score = request.POST.get('score')
        comment = request.POST.get('comment', '')
        try:
            score = int(score)
            if 1 <= score <= 10:
                rating, created = Rating.objects.update_or_create(
                    user=request.user, movie=movie,
                    defaults={'score': score, 'comment': comment}
                )
                messages.success(request, f'Ocena filmu "{movie.title}" została zapisana.')
                # Aktualizuj model na podstawie nowej oceny
                update_model_with_new_rating(request.user.id, movie.id, score)
                return redirect('movie_detail', movie_id=movie.id)
            else:
                messages.error(request, 'Ocena musi być w przedziale 1-10.')
        except ValueError:
            messages.error(request, 'Ocena musi być liczbą całkowitą.')
    return render(request, 'add_rating.html', {'movie': movie})

# Widok dodawania filmu do ulubionych przez użytkownika
@login_required
def add_to_favorites(request, movie_id):
    movie = get_object_or_404(Movie, id=movie_id)
    if request.method == 'POST':
        favorite, created = FavoriteMovie.objects.get_or_create(user=request.user, movie=movie)
        if created:
            messages.success(request, f'Film "{movie.title}" został dodany do ulubionych.')
            # Traktujemy dodanie do ulubionych jako pozytywną ocenę
            default_score = 8  # Możesz dostosować domyślną ocenę
            rating, created_rating = Rating.objects.update_or_create(
                user=request.user, movie=movie,
                defaults={'score': default_score, 'comment': 'Dodano do ulubionych'}
            )
            # Aktualizuj model na podstawie dodania do ulubionych
            update_model_with_new_rating(request.user.id, movie.id, default_score)
        else:
            messages.info(request, f'Film "{movie.title}" jest już w ulubionych.')
        return redirect('movie_detail', movie_id=movie.id)
    return render(request, 'add_to_favorites.html', {'movie': movie})


def movie_search(request):
    query = request.GET.get('q', '')
    movies = Movie.objects.filter(title__icontains=query) if query else []
    context = {
        'movies': movies,
        'query': query,
    }
    return render(request, 'movies/movie_search.html', context)

def movie_detail(request, movie_id):
    movie = get_object_or_404(Movie, id=movie_id)
    user_rating = None
    if request.user.is_authenticated:
        user_rating = Rating.objects.filter(movie=movie, user=request.user).first()
        is_favorite = FavoriteMovie.objects.filter(movie=movie, user=request.user).exists()
    else:
        is_favorite = False

    context = {
        'movie': movie,
        'user_rating': user_rating,
        'is_favorite': is_favorite,
    }
    return render(request, 'movie_detail.html', context)


@login_required
def add_to_favorites(request, movie_id):
    movie = get_object_or_404(Movie, id=movie_id)
    FavoriteMovie.objects.get_or_create(user=request.user, movie=movie)
    return redirect('movie_detail', movie_id=movie.id)

@login_required
def add_rating(request, movie_id):
    movie = get_object_or_404(Movie, id=movie_id)
    if request.method == 'POST':
        score = request.POST.get('score')
        comment = request.POST.get('comment', '')
        Rating.objects.update_or_create(
            user=request.user,
            movie=movie,
            defaults={'score': score, 'comment': comment}
        )
    return redirect('movie_detail', movie_id=movie.id)

@login_required
def edit_rating(request, movie_id):
    movie = get_object_or_404(Movie, id=movie_id)
    rating = get_object_or_404(Rating, user=request.user, movie=movie)
    if request.method == 'POST':
        rating.score = request.POST.get('score')
        rating.comment = request.POST.get('comment', '')
        rating.save()
        return redirect('movie_detail', movie_id=movie.id)
    else:
        context = {
            'movie': movie,
            'rating': rating,
        }
        return render(request, 'movies/edit_rating.html', context)