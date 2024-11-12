import React from 'react';

function LoginForm({ onLogin }) {
  return (
    <div className="login-form">
      <h1>Welcome to Movie Recommendations</h1>
      <input type="email" placeholder="Email" />
      <input type="password" placeholder="Password" />
      <button onClick={onLogin}>Log In</button>
      <button>Register</button>
    </div>
  );
}

export default LoginForm;
