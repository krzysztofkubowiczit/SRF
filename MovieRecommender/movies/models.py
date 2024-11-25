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
    poster_url = models.URLField(blank=True, null=True)
    genres = models.ManyToManyField(Genre)
    keywords = models.ManyToManyField(Keyword)
    cast = models.ManyToManyField(CastMember)
    directors = models.ManyToManyField(Director)

    def __str__(self):
        return self.title

class Rating(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    score = models.IntegerField()
    comment = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.user.username} - {self.movie.title} ({self.score})"

class FavoriteMovie(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.user.username} - {self.movie.title}"
