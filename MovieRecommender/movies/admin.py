# movies/admin.py

from django.contrib import admin
from .models import Genre, Keyword, CastMember, Director, Movie, Rating, FavoriteMovie, RecommendationFeedback

admin.site.register(Genre)
admin.site.register(Keyword)
admin.site.register(CastMember)
admin.site.register(Director)
admin.site.register(Movie)
admin.site.register(Rating)
admin.site.register(FavoriteMovie)
admin.site.register(RecommendationFeedback)
