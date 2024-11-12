// components/Registration.js
import React, { useState } from 'react';

function Registration({ onBack }) {
  const [username, setUsername] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleRegister = () => {
    console.log('Registered with:', { username, email, password });
    alert('Registration successful!');
    onBack(); // Powrót po rejestracji
  };

  return (
    <div className="registration-container">
      <h2>Register</h2>
      <input
        type="text"
        placeholder="Username"
        value={username}
        onChange={(e) => setUsername(e.target.value)}
        className="registration-input"
      />
      <input
        type="email"
        placeholder="Email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        className="registration-input"
      />
      <input
        type="password"
        placeholder="Password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        className="registration-input"
      />
      <button className="registration-button" onClick={handleRegister}>
        Register
      </button>
      <button className="back-button" onClick={onBack}>
        Back
      </button>
    </div>
  );
}

export default Registration;
