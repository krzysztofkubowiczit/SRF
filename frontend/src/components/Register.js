import React, { useState } from 'react';
import api from '../api';
import { useNavigate } from 'react-router-dom';

function Register() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    api.post('auth/register/', { username, password })
      .then(response => {
        // Możesz automatycznie zalogować użytkownika po rejestracji lub przekierować do logowania
        navigate('/login');
      })
      .catch(error => {
        console.error('Błąd podczas rejestracji:', error);
        // Dodaj obsługę błędów, np. wyświetlanie komunikatu dla użytkownika
      });
  };

  return (
    <div>
      <h1>Rejestracja</h1>
      <form onSubmit={handleSubmit}>
        <label>
          Nazwa użytkownika:
          <input
            type="text"
            value={username}
            onChange={e => setUsername(e.target.value)}
            required
          />
        </label>
        <br />
        <label>
          Hasło:
          <input
            type="password"
            value={password}
            onChange={e => setPassword(e.target.value)}
            required
          />
        </label>
        <br />
        <button type="submit">Zarejestruj się</button>
      </form>
    </div>
  );
}

export default Register;
