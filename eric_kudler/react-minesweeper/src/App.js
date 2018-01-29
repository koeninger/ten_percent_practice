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
    this.state = {
      grid: this.generateGrid(10, 15)
    }
  }
  generateGrid(width, height) {
    let grid = [];
    for (let y = 0; y < width; y++) {
      grid.push([]);
      for (let x = 0; x < height; x++) {
        grid[y].push([<Box key={y * width + x} />])
      }
    }
    return grid;
  }
  render() {
    console.log(this.state.grid)
    var rows = this.state.grid.map(function (item, i){
      var entry = item.map(function (element, j) {
        return ( 
          <td key={j}>{element}</td>
        );
      });
      return (
        <tr key={i}>{entry}</tr>
      );
    });
    return (
      <table className="board">
        <tbody>
          {rows}
        </tbody>
      </table>
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
