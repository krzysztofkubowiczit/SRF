import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import api from '../api';

function MovieList() {
  const [movies, setMovies] = useState([]);

  useEffect(() => {
    api.get('movies/')
      .then(response => {
        setMovies(response.data);
      })
      .catch(error => {
        console.error('Błąd podczas pobierania filmów:', error);
      });
  }, []);

  return (
    <div>
      <h1>Lista Filmów</h1>
      {movies.map(movie => (
        <div key={movie.id}>
          <Link to={`/movie/${movie.id}`}>
            <h2>{movie.title}</h2>
          </Link>
          {/* Możesz dodać więcej informacji, np. plakat, opis */}
        </div>
      ))}
    </div>
  );
}

export default MovieList;
