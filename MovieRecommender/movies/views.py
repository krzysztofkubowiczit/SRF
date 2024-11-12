from rest_framework import viewsets
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from rest_framework.response import Response

from .models import Movie, Rating
from .serializers import MovieSerializer, RatingSerializer
from .recommendations import knn_recommendation, matrix_factorization_recommendation

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrReadOnly])
def recommend_movies(request):
    user = request.user
    if user.is_authenticated:
        recommendations = matrix_factorization_recommendation(user.id)
    else:
        recommendations = knn_recommendation()
    serializer = MovieSerializer(recommendations, many=True)
    return Response(serializer.data)

class MovieViewSet(viewsets.ModelViewSet):
    queryset = Movie.objects.all()
    serializer_class = MovieSerializer

class RatingViewSet(viewsets.ModelViewSet):
    queryset = Rating.objects.all()
    serializer_class = RatingSerializer