from django.urls import path, include
from rest_framework import routers
from .views import MovieViewSet, RatingViewSet, recommend_movies

router = routers.DefaultRouter()
router.register(r'movies', MovieViewSet)
router.register(r'ratings', RatingViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('recommend/', recommend_movies),
]