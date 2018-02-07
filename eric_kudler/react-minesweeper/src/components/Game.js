import React, { Component } from 'react';
import { Header } from './Header.js';

export class Box extends Component {
  render() {
    return (
      <div>
        <button className="box"></button>
      </div>
    );
  }
}
export class Board extends Component {
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

export class Game extends Component {
  constructor(props) {
    super(props);
    this.state = {
      active: false,
      seconds: 0
    }
    this.startGame = this.startGame.bind(this);
  }
  componentDidMount() {
    
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
  startGame() {
    this.setState({
      active: true
    });
    this.timerID = setInterval(
      () => this.tick(),
      1000
    );
  }
  render() {
    return (
      <div className="game">
        <Header bombs={this.props.bombs} startGame={this.startGame} seconds={this.state.seconds} />
        <Board width={this.props.width} height={this.props.height} bombs={this.props.bombs} />
      </div>
    );
  }
}