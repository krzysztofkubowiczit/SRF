import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:8000/api/',
  withCredentials: true, // Umożliwia wysyłanie ciasteczek (np. sesji)
});

export default api;
