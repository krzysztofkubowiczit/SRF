import React, { useState, useEffect } from 'react';
import api from '../api';

function FavoriteButton({ movieId }) {
  const [isFavorite, setIsFavorite] = useState(false);

  useEffect(() => {
    api.get(`favorites/${movieId}/`)
      .then(response => {
        setIsFavorite(response.data.is_favorite);
      })
      .catch(error => {
        console.error('Błąd podczas sprawdzania ulubionych:', error);
      });
  }, [movieId]);

  const handleClick = () => {
    if (isFavorite) {
      api.delete(`favorites/${movieId}/`)
        .then(() => {
          setIsFavorite(false);
        })
        .catch(error => {
          console.error('Błąd podczas usuwania z ulubionych:', error);
        });
    } else {
      api.post('favorites/', { movie: movieId })
        .then(() => {
          setIsFavorite(true);
        })
        .catch(error => {
          console.error('Błąd podczas dodawania do ulubionych:', error);
        });
    }
  };

  return (
    <button onClick={handleClick}>
      {isFavorite ? 'Usuń z ulubionych' : 'Dodaj do ulubionych'}
    </button>
  );
}

export default FavoriteButton;
