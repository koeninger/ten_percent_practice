import React, { Component } from 'react';

export class GameButton extends Component {
  render() {
    return (
      <button className="game-button" onClick={this.props.startGame}>(:</button>
    );
  }
}

export class Timer extends Component {
  render() {
    return (
      <input className="digital timer" type="text" name="timer" value={this.props.seconds.toString().padStart(3, '0')} />
    );
  }
}

export class Counter extends Component {
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

export class Header extends Component {
  render() {
    return (
      <div>
        <Timer seconds={this.props.seconds} />
        <GameButton startGame={this.props.startGame} />
        <Counter />
      </div>
    );
  }
}