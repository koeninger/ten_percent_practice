import React, { Component } from 'react';

import { Game } from './components/Game.js';
import logo from './logo.svg';
import './App.css';

class Minesweeper extends Component {
  render() {
    return (
      <Game width="10" height="10" bombs="10" />
    );
  }
}
class App extends Component {
  render() {
    return (
      <Minesweeper />
    );
  }
}

export default App;
