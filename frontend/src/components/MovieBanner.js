// components/MovieBanner.js
import React from 'react';

function MovieBanner({ movie }) {
  return (
    <div className="movie-banner">
      <img src={movie.image} alt={movie.title} className="movie-banner-image" />
      <div className="movie-banner-description">
        <h2>{movie.title}</h2>
        <p>{movie.description}</p>
      </div>
    </div>
  );
}

export default MovieBanner;
