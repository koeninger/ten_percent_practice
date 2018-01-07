import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class Card extends Component {
  constructor(props) {
    super(props);
    var rank;
    var number = parseInt(this.props.number);
    switch (number) {
      case 1:
        rank = 'A';
        break;
      case 11:
        rank = 'J';
        break;
      case 12:
        rank = 'Q';
        break;
      case 13:
        rank = 'K';
        break;
      default:
        rank = this.props.number;
    }
    this.state = {
      rank: rank,
      suit: this.props.suit
    }
  }
  render() {
    return (
      <div className="card">
        {this.state.rank}
        {this.state.suit}
      </div>
    );
  }
}

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1 className="App-title">Welcome to React</h1>
        </header>
        <p className="App-intro">
          <Card number="1" suit="H" />
        </p>
      </div>
    );
  }
}

export default App;
