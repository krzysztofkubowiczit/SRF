// components/FilterForm.js
import React, { useState } from 'react';

function FilterForm({ onFilterChange }) {
  const [filters, setFilters] = useState({
    genre: '',
    keywords: '',
    director: '',
  });

  const genres = [
    '', // Pusta opcja
    'Action',
    'Comedy',
    'Drama',
    'Horror',
    'Sci-Fi',
    'Romance',
    'Thriller',
    'Fantasy',
    'Animation',
    'Documentary',
  ];

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFilters((prevFilters) => ({
      ...prevFilters,
      [name]: value,
    }));
  };

  const handleSearchClick = () => {
    onFilterChange(filters);
  };

  const isSearchButtonVisible = filters.genre || filters.keywords || filters.director;

  return (
    <div className="filter-form">
      <select
        name="genre"
        value={filters.genre}
        onChange={handleInputChange}
        className="filter-select"
      >
        {genres.map((genre, index) => (
          <option key={index} value={genre}>
            {genre || 'Select Genre'}
          </option>
        ))}
      </select>
      <input
        type="text"
        name="keywords"
        value={filters.keywords}
        placeholder="Keywords (comma separated)"
        onChange={handleInputChange}
        className="filter-input"
      />
      <input
        type="text"
        name="director"
        value={filters.director}
        placeholder="Director"
        onChange={handleInputChange}
        className="filter-input"
      />
      {isSearchButtonVisible && (
        <button onClick={handleSearchClick} className="search-button">
          Search
        </button>
      )}
    </div>
  );
}

export default FilterForm;
