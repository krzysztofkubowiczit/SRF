# movies/views.py

from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth import login
from django.contrib.auth.decorators import login_required
from django.db.models import Avg, Count
from .models import Movie, Rating
from .forms import UserRegisterForm

def home(request):
    # 5 najpopularniejszych filmów
    popular_movies = Movie.objects.annotate(avg_rating=Avg('rating__score')).order_by('-avg_rating')[:5]

    # 5 najnowszych filmów
    newest_movies = Movie.objects.all().order_by('-release_year')[:5]

    # 5 najczęściej ocenianych filmów
    most_rated_movies = Movie.objects.annotate(rating_count=Count('rating')).order_by('-rating_count')[:5]

    context = {
        'popular_movies': popular_movies,
        'newest_movies': newest_movies,
        'most_rated_movies': most_rated_movies,
    }

    return render(request, 'home.html', context)

def guest_recommendations(request):
    from .recommendations import knn_recommendation
    recommendations = knn_recommendation()

    context = {
        'recommendations': recommendations
    }

    return render(request, 'guest_recommendations.html', context)

@login_required
def user_recommendations(request):
    from .recommendations import recommend_movies_for_user
    recommendations = recommend_movies_for_user(request.user)

    context = {
        'recommendations': recommendations
    }

    return render(request, 'user_recommendations.html', context)

def register(request):
    if request.method == 'POST':
        form = UserRegisterForm(request.POST)
        if form.is_valid():
            user = form.save()
            username = form.cleaned_data.get('username')
            messages.success(request, f'Konto zostało utworzone dla {username}! Możesz się teraz zalogować.')
            login(request, user)
            return redirect('home')
    else:
        form = UserRegisterForm()
    return render(request, 'register.html', {'form': form})
