import React, { useEffect, useState } from 'react';
import api from '../api';

function Recommendations() {
  const [movies, setMovies] = useState([]);

  useEffect(() => {
    api.get('recommend/')
      .then(response => {
        setMovies(response.data);
      })
      .catch(error => {
        console.error('Błąd podczas pobierania rekomendacji:', error);
      });
  }, []);

  return (
    <div>
      <h1>Rekomendacje Filmowe</h1>
      {movies.map(movie => (
        <div key={movie.id}>
          <h2>{movie.title}</h2>
          {/* Dodaj więcej informacji */}
        </div>
      ))}
    </div>
  );
}

export default Recommendations;
