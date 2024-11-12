from rest_framework import serializers
from .models import Movie, Genre, Keyword, CastMember, Director, Rating

class GenreSerializer(serializers.ModelSerializer):
    class Meta:
        model = Genre
        fields = '__all__'

class KeywordSerializer(serializers.ModelSerializer):
    class Meta:
        model = Keyword
        fields = '__all__'

class CastMemberSerializer(serializers.ModelSerializer):
    class Meta:
        model = CastMember
        fields = '__all__'

class DirectorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Director
        fields = '__all__'

class MovieSerializer(serializers.ModelSerializer):
    genres = GenreSerializer(many=True)
    keywords = KeywordSerializer(many=True)
    cast = CastMemberSerializer(many=True)
    directors = DirectorSerializer(many=True)

    class Meta:
        model = Movie
        fields = '__all__'

class RatingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Rating
        fields = '__all__'
class MovieSerializer(serializers.ModelSerializer):
    class Meta:
        model = Movie
        fields = '__all__'

class RatingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Rating
        fields = '__all__'