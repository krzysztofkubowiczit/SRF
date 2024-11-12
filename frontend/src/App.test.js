import { render, screen } from '@testing-library/react';
import App from './App';

test('renders Random button', () => {
  render(<App />);
  const buttonElement = screen.getByText(/Random/i);
  expect(buttonElement).toBeInTheDocument();
});
