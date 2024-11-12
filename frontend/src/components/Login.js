import React, { useState, useContext } from 'react';
import api from '../api';
import { useNavigate } from 'react-router-dom';
import { AuthContext } from '../AuthContext';

function Login() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const { setUser } = useContext(AuthContext);
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    api.post('auth/login/', { username, password })
      .then(response => {
        setUser(response.data.user); // Zakładając, że backend zwraca dane użytkownika w polu 'user'
        navigate('/');
      })
      .catch(error => {
        console.error('Błąd podczas logowania:', error);
        // Możesz dodać obsługę błędów, np. wyświetlanie komunikatu dla użytkownika
      });
  };

  return (
    <div>
      <h1>Logowanie</h1>
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
        <button type="submit">Zaloguj się</button>
      </form>
    </div>
  );
}

export default Login;
