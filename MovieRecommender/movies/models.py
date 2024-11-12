from django.db import models
from django.contrib.auth.models import User

class Genre(models.Model):
    name = models.CharField(max_length=255)

    def __str__(self):
        return self.name

class Keyword(models.Model):
    name = models.CharField(max_length=255)

    def __str__(self):
        return self.name

class CastMember(models.Model):
    name = models.CharField(max_length=255)

    def __str__(self):
        return self.name

class Director(models.Model):
    name = models.CharField(max_length=255)

    def __str__(self):
        return self.name

class Movie(models.Model):
    title = models.CharField(max_length=255)
    release_year = models.IntegerField()
    description = models.TextField()
    poster_url = models.URLField()
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
    comment = models.TextField(null=True, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

class FavoriteMovie(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
