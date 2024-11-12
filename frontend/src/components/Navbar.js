import React, { useContext } from 'react';
import { Link } from 'react-router-dom';
import { AuthContext } from '../AuthContext';
import api from '../api';

function Navbar() {
  const { user, setUser } = useContext(AuthContext);

  const handleLogout = () => {
    api.post('auth/logout/')
      .then(() => {
        setUser(null);
      })
      .catch(error => {
        console.error('Błąd podczas wylogowywania:', error);
      });
  };

  return (
    <nav>
      <ul>
        <li><Link to="/">Strona Główna</Link></li>
        {user && <li><Link to="/recommendations">Rekomendacje</Link></li>}
        {user ? (
          <>
            <li>Cześć, {user.username}</li>
            <li><button onClick={handleLogout}>Wyloguj się</button></li>
          </>
        ) : (
          <>
            <li><Link to="/login">Logowanie</Link></li>
            <li><Link to="/register">Rejestracja</Link></li>
          </>
        )}
      </ul>
    </nav>
  );
}

export default Navbar;
