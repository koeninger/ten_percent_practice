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
    let openClass = '';
    if (this.props.is_bomb) {
      openClass = 'bomb';
    }

    return (
      <div>
        <button className={"box " + (this.props.open ? 'open ' : 'unopened') + ' ' + openClass} onClick={this.openBox}>{this.props.bomb_neighbors > 0 ? this.props.bomb_neighbors : ''}</button>
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
              is_bomb={element.is_bomb}
              bomb_neighbors={element.bomb_neighbors}
              openBox={self.openBox} />
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

    //set/reset timer
    if (this.timerID) {
      clearInterval(this.timerID);
    }
    this.timerID = setInterval(
      () => this.tick(),
      1000
    );

    //reset grid
    let grid = this.state.grid;
    for (let y = 0; y < this.props.width; y++) {
      grid.push([]);
      for (let x = 0; x < this.props.height; x++) {
        grid[y][x].is_bomb = false;
        grid[y][x].open = false;
        grid[y][x].bomb_neighbors = 0;
      }
    }

    //set bombs
    let bombs = this.props.bombs;
    while (bombs > 0) {
      let x = Math.floor(Math.random() * this.props.width);
      let y = Math.floor(Math.random() * this.props.height);
      if (grid[y][x].is_bomb) {
        continue;
      }

      grid[y][x].is_bomb = true;
      this.incrementNeighbors(grid, x, y, this.props.width, this.props.height)
      this.setState({
        grid: grid
      });
      bombs--;
    }
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
          is_bomb: false,
          open: false,
          bomb_neighbors: 0
        }
        grid[y].push(box)
      }
    }
    return grid;
  }
  incrementNeighbors(grid, x, y, width, height) {
    if (y > 0) {
      grid[y - 1][x].bomb_neighbors++;
    }
    if (x > 0) {
      grid[y][x - 1].bomb_neighbors++;
    }
    if (y < height - 1) {
      grid[y + 1][x].bomb_neighbors++;
    }
    if (x < width - 1) {
      grid[y][x + 1].bomb_neighbors++;
    }

    if (y > 0 && x < width - 1) {
      grid[y - 1][x + 1].bomb_neighbors++;
    }
    if (x > 0 && y < height - 1) {
      grid[y + 1][x - 1].bomb_neighbors++;
    }
    if (y > 0 && x > 0) {
      grid[y - 1][x - 1].bomb_neighbors++;
    }
    if (x < width - 1 && y < height - 1) {
      grid[y + 1][x + 1].bomb_neighbors++;
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