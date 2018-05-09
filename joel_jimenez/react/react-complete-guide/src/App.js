import React, { Component } from 'react';
import Header from './Header';
import { BrowserRouter } from 'react-router-dom';

class App extends Component {
  render() {
    return (
      <BrowserRouter>
        <Header />
		{/* 
			Account selection
			List of transactions
		*/}
      </BrowserRouter>
    );
  }
}

export default App;
