import React, { useState } from 'react';
import api from '../api';

function Rating({ movieId }) {
  const [score, setScore] = useState(0);
  const [comment, setComment] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    api.post('ratings/', { movie: movieId, score, comment })
      .then(response => {
        alert('Dziękujemy za ocenę!');
      })
      .catch(error => {
        console.error('Błąd podczas dodawania oceny:', error);
      });
  };

  return (
    <div>
      <h3>Oceń ten film:</h3>
      <form onSubmit={handleSubmit}>
        <label>
          Ocena (1-5):
          <input type="number" min="1" max="5" value={score} onChange={e => setScore(e.target.value)} />
        </label>
        <br />
        <label>
          Komentarz:
          <textarea value={comment} onChange={e => setComment(e.target.value)} />
        </label>
        <br />
        <button type="submit">Wyślij ocenę</button>
      </form>
    </div>
  );
}

export default Rating;
