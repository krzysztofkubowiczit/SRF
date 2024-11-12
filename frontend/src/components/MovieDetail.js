import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import api from '../api';
import Rating from './Rating';
import FavoriteButton from './FavoriteButton';

function MovieDetail() {
  const { id } = useParams();
  const [movie, setMovie] = useState(null);

  useEffect(() => {
    api.get(`movies/${id}/`)
      .then(response => {
        setMovie(response.data);
      })
      .catch(error => {
        console.error('Błąd podczas pobierania szczegółów filmu:', error);
      });
  }, [id]);

  if (!movie) return <div>Ładowanie...</div>;

  return (
    <div>
      <h1>{movie.title}</h1>
      <p>{movie.description}</p>
      <p><strong>Rok wydania:</strong> {movie.release_year}</p>
      <p><strong>Gatunki:</strong> {movie.genres.map(genre => genre.name).join(', ')}</p>
      <p><strong>Reżyserzy:</strong> {movie.directors.map(director => director.name).join(', ')}</p>
      <p><strong>Obsada:</strong> {movie.cast.map(castMember => castMember.name).join(', ')}</p>

      {/* Komponenty do oceniania i dodawania do ulubionych */}
      <FavoriteButton movieId={movie.id} />
      <Rating movieId={movie.id} />

      {/* Wyświetlanie ocen */}
      <h3>Oceny użytkowników:</h3>
      {movie.ratings && movie.ratings.length > 0 ? (
        movie.ratings.map(rating => (
          <div key={rating.id}>
            <p><strong>Użytkownik:</strong> {rating.user.username}</p>
            <p><strong>Ocena:</strong> {rating.score}</p>
            <p><strong>Komentarz:</strong> {rating.comment}</p>
          </div>
        ))
      ) : (
        <p>Brak ocen dla tego filmu.</p>
      )}
    </div>
  );
}

export default MovieDetail;
