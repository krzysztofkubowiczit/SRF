// components/Modal.js
import React from 'react';
import './Modal.css';

function Modal({ title, children, onClose }) {
  return (
    <div className="modal-overlay">
      <div className="modal-content">
        <div className="modal-header">
          <h2>{title}</h2>
          <button className="close-button" onClick={onClose}>
            X
          </button>
        </div>
        <div className="modal-body">{children}</div>
      </div>
    </div>
  );
}

export default Modal;
