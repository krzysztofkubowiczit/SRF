import React, { useEffect, useState } from 'react';
import Header from './components/Header';
import Footer from './components/Footer';
import MovieBanner from './components/MovieBanner';
import FilterForm from './components/FilterForm';
import Registration from './components/Registration';
import Modal from './components/Modal';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faArrowLeft, faFilter } from '@fortawesome/free-solid-svg-icons';
import './index.css';

function App() {
  const [movies, setMovies] = useState([]);
  const [showMovies, setShowMovies] = useState(false);
  const [showRegistration, setShowRegistration] = useState(false);
  const [filters, setFilters] = useState({ genre: '', keywords: '', director: '' });
  const [isDarkTheme, setIsDarkTheme] = useState(true);
  const [showFilterForm, setShowFilterForm] = useState(false);
  const [showModal, setShowModal] = useState({ about: false, contact: false });

  // Przełączanie motywu
  const toggleTheme = () => {
    setIsDarkTheme(!isDarkTheme);
  };

  // Generowanie losowych filmów do demonstracji
  const generateRandomMovies = () => {
    const generatedMovies = Array.from({ length: 10 }, (_, index) => ({
      title: `Random Movie ${index + 1}`,
      genre: ['Action', 'Comedy', 'Drama', 'Horror', 'Sci-Fi'][Math.floor(Math.random() * 5)],
      director: `Director ${Math.floor(Math.random() * 5) + 1}`,
      description: `This is the description for Random Movie ${index + 1}. It's a fascinating story about adventures, challenges, and emotions.`,
      image: `https://via.placeholder.com/300x450?text=Movie+${index + 1}`,
      keywords: ['Adventure', 'Fantasy', 'Thriller', 'Romance', 'Mystery']
        .sort(() => 0.5 - Math.random())
        .slice(0, 2)
        .join(', '),
    }));
    setMovies(generatedMovies);
  };

  useEffect(() => {
    generateRandomMovies();
  }, []);

  const handleFilterChange = (newFilters) => {
    setFilters(newFilters);
    setShowMovies(true);
  };

  const filteredMovies = movies.filter((movie) => {
    const genreMatch = !filters.genre || movie.genre.toLowerCase().includes(filters.genre.toLowerCase());
    const directorMatch = !filters.director || movie.director.toLowerCase().includes(filters.director.toLowerCase());
    const keywordMatch =
      !filters.keywords ||
      filters.keywords
        .split(',')
        .map((kw) => kw.trim().toLowerCase())
        .every((kw) => movie.keywords.toLowerCase().includes(kw));

    return genreMatch && directorMatch && keywordMatch;
  });

  return (
    <div className={isDarkTheme ? 'dark-theme App' : 'light-theme App'}>
      <Header
        onRegisterClick={() => {
          setShowRegistration(true);
          setShowMovies(false);
        }}
        onLogoClick={() => {
          setShowRegistration(false);
          setShowMovies(false);
        }}
        toggleTheme={toggleTheme}
        isDarkTheme={isDarkTheme}
      />
      <main className="main-content">
        {showMovies && (
          <div className="back-arrow" onClick={() => setShowMovies(false)}>
            <FontAwesomeIcon icon={faArrowLeft} size="2x" color={isDarkTheme ? '#c0c0c0' : '#000000'} />
          </div>
        )}
        {!showMovies && !showRegistration && (
          <>
            <div className="filter-section">
              <button className="random-button" onClick={() => setShowMovies(true)}>
                Random
              </button>
              <div className="filter-icon" onClick={() => setShowFilterForm(!showFilterForm)}>
                <FontAwesomeIcon icon={faFilter} size="2x" color={isDarkTheme ? '#c0c0c0' : '#000000'} />
              </div>
              {showFilterForm && <FilterForm onFilterChange={handleFilterChange} />}
            </div>
          </>
        )}
        {showMovies && !showRegistration && (
          <>
            <div className="movie-banner-container">
              {filteredMovies.length > 0 ? (
                filteredMovies.map((movie, index) => <MovieBanner key={index} movie={movie} />)
              ) : (
                <p>No movies match the selected filters.</p>
              )}
            </div>
          </>
        )}
        {showRegistration && (
          <>
            <Registration onBack={() => setShowRegistration(false)} />
          </>
        )}
      </main>
      <Footer
        onAboutClick={() => setShowModal({ about: true, contact: false })}
        onContactClick={() => setShowModal({ about: false, contact: true })}
      />

      {showModal.about && (
        <Modal title="About" onClose={() => setShowModal({ about: false, contact: false })}>
          <p>
            This is the Movie Recommendation Service (MRS). Here you can discover new movies based on your preferences.
          </p>
        </Modal>
      )}

      {showModal.contact && (
        <Modal title="Contact" onClose={() => setShowModal({ about: false, contact: false })}>
          <p>For more information, please contact us at contact@mrs.com.</p>
        </Modal>
      )}
    </div>
  );
}

export default App;
