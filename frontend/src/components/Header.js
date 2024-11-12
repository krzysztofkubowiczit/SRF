// components/Header.js
import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faHome } from '@fortawesome/free-solid-svg-icons';
import './Header.css';

function Header({ onRegisterClick, onLogoClick, toggleTheme, isDarkTheme }) {
  return (
    <header className="header">
      <div className="left-section">
        <div className="logo-container" onClick={onLogoClick}>
          <FontAwesomeIcon icon={faHome} size="lg" />
        </div>
        <div className="theme-toggle">
          <label className="switch">
            <input type="checkbox" checked={isDarkTheme} onChange={toggleTheme} />
            <span className="slider round"></span>
          </label>
          <span className="theme-label">{isDarkTheme ? 'Dark Mode' : 'Light Mode'}</span>
        </div>
      </div>
      <div className="right-section login-register">
        <input type="text" placeholder="Username" className="login-input" />
        <input type="password" placeholder="Password" className="login-input" />
        <button className="nav-button">Log In</button>
        <button className="nav-button register-button" onClick={onRegisterClick}>
          Register
        </button>
      </div>
    </header>
  );
}

export default Header;
