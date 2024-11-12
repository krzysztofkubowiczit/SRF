import React, { createContext, useState, useEffect } from 'react';
import api from './api';

export const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);

  useEffect(() => {
    // Sprawdź, czy użytkownik jest zalogowany
    api.get('auth/user/')
      .then(response => {
        setUser(response.data);
      })
      .catch(() => {
        setUser(null);
      });
  }, []);

  return (
    <AuthContext.Provider value={{ user, setUser }}>
      {children}
    </AuthContext.Provider>
  );
};
