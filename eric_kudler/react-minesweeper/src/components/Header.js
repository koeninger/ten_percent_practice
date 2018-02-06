import React, { Component } from 'react';

export class GameButton extends Component {
  render() {
    return (
      <button className="game-button" onClick={this.props.startGame}>(:</button>
    );
  }
}

export class Timer extends Component {
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
        <Timer />
        <GameButton startGame={this.props.startGame} />
        <Counter />
      </div>
    );
  }
}