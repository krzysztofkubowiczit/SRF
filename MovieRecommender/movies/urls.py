# movies/urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('register/', views.register, name='register'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('guest_recommendations/', views.guest_recommendations, name='guest_recommendations'),
    path('user_recommendations/', views.user_recommendations, name='user_recommendations'),
    path('movie/<int:movie_id>/', views.movie_detail, name='movie_detail'),
    path('movie/<int:movie_id>/add_rating/', views.add_rating, name='add_rating'),
    path('movie/<int:movie_id>/add_to_favorites/', views.add_to_favorites, name='add_to_favorites'),
    path('user_profile/', views.user_profile, name='user_profile'),
    path('user_favorites/', views.user_favorites, name='user_favorites'),
    path('user_ratings/', views.user_ratings, name='user_ratings'),
    # Movie search results (optional)
    path('search/', views.movie_search, name='movie_search'),
    # Movie detail page
    path('movies/<int:movie_id>/', views.movie_detail, name='movie_detail'),
    # Add to favorites
    path('movies/<int:movie_id>/add_to_favorites/', views.add_to_favorites, name='add_to_favorites'),
    # Add rating
    path('movies/<int:movie_id>/add_rating/', views.add_rating, name='add_rating'),
    # Edit rating
    path('movies/<int:movie_id>/edit_rating/', views.edit_rating, name='edit_rating'),
]
