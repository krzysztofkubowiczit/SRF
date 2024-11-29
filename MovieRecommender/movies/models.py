# movies/models.py

from django.db import models
from django.contrib.auth.models import User

class Genre(models.Model):
    name = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.name

class Keyword(models.Model):
    name = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.name

class CastMember(models.Model):
    name = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.name

class Director(models.Model):
    name = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.name

class Movie(models.Model):
    title = models.CharField(max_length=200)
    release_year = models.IntegerField()
    description = models.TextField(blank=True, null=True)
    poster_url = models.URLField(blank=True, null=True)  # Zmieniono nazwę pola na 'poster_url'
    genres = models.ManyToManyField(Genre, blank=True)
    keywords = models.ManyToManyField(Keyword, blank=True)
    cast = models.ManyToManyField(CastMember, blank=True)
    directors = models.ManyToManyField(Director, blank=True)

    def __str__(self):
        return self.title

class Rating(models.Model):
    score = models.IntegerField()
    comment = models.TextField(blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)  # Automatically set
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.user.username} - {self.movie.title} ({self.score})"

class FavoriteMovie(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.user.username} - {self.movie.title}"

class RecommendationFeedback(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    recommendation = models.JSONField()
    score = models.IntegerField()
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        user_info = self.user.username if self.user else "Anonimowy"
        return f"{user_info} - Ocena rekomendacji: {self.score}"
