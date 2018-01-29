import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';


class Box extends Component {
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <div>
        <button className="box"></button>
      </div>
    );
  }
}
class Board extends Component {
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <div>
        <Box />
        <Box />
        <Box />
        <Box />
      </div>
    );
  }
}
class Header extends Component {
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <div>
      Header
      </div>
    );
  }
}
class Game extends Component {
  render() {
    return (
      <div className="game">
        <Header />
        <Board />
      </div>
    );
  }
}
class Minesweeper extends Component {
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <Game />
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
