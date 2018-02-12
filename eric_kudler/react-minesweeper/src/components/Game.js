import React, { Component } from 'react';
import { Header } from './Header.js';

export class Box extends Component {
  constructor(props) {
    super(props);
    this.openBox = this.openBox.bind(this);
  }
  openBox() {
    this.props.openBox(this.props.x, this.props.y);
  }
  render() {
    return (
      <div>
        <button className={"box " + (this.props.open ? 'open' : '')} onClick={this.openBox}></button>
      </div>
    );
  }
}
export class Board extends Component {
  constructor(props) {
    super(props);
    this.openBox = this.openBox.bind(this);
  }
  openBox(x, y) {
    this.props.openBox(x, y);
  }
  render() {
    var self = this;
    var rows = this.props.grid.map(function (item, i){
      var entry = item.map(function (element, j) {
        return ( 
          <td key={j}>
            <Box 
              key={element.key}
              x={element.x}
              y={element.y}
              open={element.open}
              openBox={self.openBox}
              value={element.value} />
          </td>
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
      grid: this.generateGrid(props.width, props.height),
      seconds: 0
    }
    this.startGame = this.startGame.bind(this);
    this.tick = this.tick.bind(this);
    this.openBox = this.openBox.bind(this);
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
      active: true,
      seconds: 0
    });
    if (this.timerID) {
      clearInterval(this.timerID);
    }
    this.timerID = setInterval(
      () => this.tick(),
      1000
    );
  }
  openBox(x, y) {
    this.setState(function(prevState, props) {
      let grid = prevState.grid;
      grid[y][x].open = true;
      return {
        grid: grid
      }
    });

  }
  generateGrid(width, height) {
    let grid = [];
    for (let y = 0; y < width; y++) {
      grid.push([]);
      for (let x = 0; x < height; x++) {
        let box = {
          x: x,
          y: y,
          key: y * width + x,
          open: false,
          value: 'E'
        }
        grid[y].push(box)
      }
    }
    return grid;
  }
  render() {
    return (
      <div className="game">
        <Header bombs={this.props.bombs} startGame={this.startGame} seconds={this.state.seconds} />
        <Board width={this.props.width} height={this.props.height} bombs={this.props.bombs} grid={this.state.grid} openBox={this.openBox}/>
      </div>
    );
  }
}