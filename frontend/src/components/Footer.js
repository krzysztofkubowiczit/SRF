// components/Footer.js
import React from 'react';

function Footer({ onAboutClick, onContactClick }) {
  return (
    <footer className="footer">
      <div className="footer-content">
        <button className="footer-button" onClick={onAboutClick}>
          About
        </button>
        <button className="footer-button" onClick={onContactClick}>
          Contact
        </button>
      </div>
    </footer>
  );
}

export default Footer;
