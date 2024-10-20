from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import UserViewSet, MovieViewSet, RatingViewSet, FavoriteViewSet

# Tworzymy router i rejestrujemy nasze widoki
router = DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'movies', MovieViewSet)
router.register(r'ratings', RatingViewSet)
router.register(r'favorites', FavoriteViewSet)

urlpatterns = [
    path('', include(router.urls)),  # Dodajemy wszystkie nasze endpointy
]
