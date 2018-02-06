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
      grid: this.generateGrid(props.width, props.height)
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
class Timer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      seconds: 0
    }
  }
  componentDidMount() {
    this.timerID = setInterval(
      () => this.tick(),
      1000
    );
  }
  componentWillUnmount() {
    clearInterval(this.timerID);
  }
  tick() {
    this.setState(function(prevState, props) {
      return {
        seconds: prevState.seconds + 1
      }
    });
  }
  render() {
    return (
      <input className="digital timer" type="text" name="timer" value={this.state.seconds.toString().padStart(3, '0')} />
    );
  }
}
class Counter extends Component {
  constructor(props) {
    super(props);
    this.state = {
      bombs: 10
    }
  }
  render() {
    return (
      <input className="digital counter" type="text" name="counter" value={this.state.bombs.toString().padStart(3, '0')} />
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
        <Timer />
        <button className="game-button">(:</button>
        <Counter />
      </div>
    );
  }
}
class Game extends Component {
  render() {
    return (
      <div className="game">
        <Header bombs={this.props.bombs} />
        <Board width={this.props.width} height={this.props.height} bombs={this.props.bombs} />
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
