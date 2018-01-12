import React from 'react';
import ReactDOM from 'react-dom';
import { Panel, Jumbotron, Button } from 'react-bootstrap';
import { Row, Col } from 'react-bootstrap';
import { Navbar, Nav, NavItem, NavDropdown, MenuItem} from 'react-bootstrap';
import InterestsPanel from './common/panels/InterestsPanel';
import SettingsPanel from './common/panels/SettingsPanel';
import AttractionsPanel  from './common/panels/AttractionsPanel';
import InfoPanel from './common/panels/InfoPanel';
import DatePicker from 'react-datepicker';
import moment from 'moment';

import uniqueId from 'lodash/uniqueId';
import Sortable from 'react-sortablejs';

import './index.css';
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap/dist/css/bootstrap-theme.css';
import 'react-datepicker/dist/react-datepicker.css';

class Square extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			value: null,
		};
	}
	render() {
		return (
				<button className="square" onClick={() => this.props.onClick()}>
					{this.props.value}
				</button>
		);
	}
}

class Board extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			squares: Array(9).fill(null),
			xIsNext: true
		};
	}

	renderSquare(i) {
		return <Square  value={this.props.squares[i]} onClick={() => this.props.onClick(i)} />;
	}

	render() {
		return (
				<div>
					<div className="board-row">
						{this.renderSquare(0)}
						{this.renderSquare(1)}
						{this.renderSquare(2)}
					</div>
					<div className="board-row">
						{this.renderSquare(3)}
						{this.renderSquare(4)}
						{this.renderSquare(5)}
					</div>
					<div className="board-row">
						{this.renderSquare(6)}
						{this.renderSquare(7)}
						{this.renderSquare(8)}
					</div>
				</div>
			);
	}
}

class Game extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			history: [{
				squares: Array(9).fill(null),
			}],
			xIsNext: true,
			stepNumber: 0,
		};
  	}

  	handleClick(i) {
		const history = this.state.history;
		const current = history[history.length - 1];
		const squares = current.squares.slice();

		if (calculateWinner(squares) || squares[i]) {
			return;
		}
		squares[i] = this.state.xIsNext ? 'X' : 'O';
		this.setState({
			history: history.concat([{
		        squares: squares,
		    }]),
			xIsNext: !this.state.xIsNext,
		});
	}
	jumpTo(step) {
		this.setState({
			stepNumber: step,
			xIsNext: (step % 2) === 0,
		});
	}
	render() {
		const history = this.state.history;
		const current = history[history.length - 1];
		const winner = calculateWinner(current.squares);
		const moves = history.map((step, move) => {
      		const desc = move ?
				'Go to move #' + move :
				'Go to game start';
			return (
				<li key={move}>
					<button onClick={() => this.jumpTo(move)}>{desc}</button>
				</li>
			);
    	});
		let status;
		if (winner) {
			status = 'Winner: ' + winner;
		} else {
			status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O');
		}
		return (
			<div className="game">
				<div className="game-board">
					<Board squares={current.squares} onClick={(i) => this.handleClick(i)}/>
				</div>
				<div className="game-info">
					<div>{status}</div>
					<ol>{moves}</ol>
				</div>
			</div>
		);
	}
}


// ========================================
class NavigationBar extends React.Component {
	render() {
		return (
			<Navbar>
				<Navbar.Header>
					<Navbar.Brand>
						<a href="#">Vacation Navigator</a>
					</Navbar.Brand>
				</Navbar.Header>
				<Nav>
					<NavItem eventKey={1} href="#">Link</NavItem>
					<NavItem eventKey={2} href="#">Link</NavItem>
					<NavDropdown eventKey={3} title="Dropdown" id="basic-nav-dropdown">
						<MenuItem eventKey={3.1}>Action</MenuItem>
						<MenuItem eventKey={3.2}>Another action</MenuItem>
						<MenuItem eventKey={3.3}>Something else here</MenuItem>
						<MenuItem divider />
						<MenuItem eventKey={3.4}>Separated link</MenuItem>
					</NavDropdown>
				</Nav>
			</Navbar>
		);
	}
}

class ControlPanel extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			current_attraction: null,
			attractions: [
				{
					id: 0,
					name: 'Stich\'s Great Escape'
				},
				{
					id: 1,
					name: 'Mickey\'s PhillharMagic'
				},
				{
					id: 2,
					name: 'Seven Dwarfs Mine Train'
				}, 
				{
					id: 3,
					name: 'Pirates of the Carribean'
				},
				{
					id: 4,
					name: 'Haunted Mansion'
				}, 
				{
					id: 5,
					name: 'Jungle Cruise'
				}, 
				{
					id: 6,
					name: 'Space Mountain'
				}
			]
		};
		this.setCurrentAttraction = this.setCurrentAttraction.bind(this);
	}
	setCurrentAttraction(attraction_id) {
		this.setState({
			current: attraction_id
		})
	}
	render() {
		return (
			<div className="container control-panel">
				<Row>
					<Col md={6}>
						<SettingsPanel />
					</Col>
					<Col md={3}>
						<AttractionsPanel attractions={this.state.attractions} setCurrentAttraction={this.setCurrentAttraction} />
					</Col>
					<Col md={3}>
						<InterestsPanel attractions={this.state.attractions} setCurrentAttraction={this.setCurrentAttraction} />
					</Col>
				</Row>
				<Row>
					<Col md={6}>
						<InfoPanel />
					</Col>
				</Row>
			</div>
		)
	}
}
class Navigator extends React.Component {
	constructor(props) {
		super(props);
	}
	render() {
		return (
			<div>
  				<NavigationBar />
  				<ControlPanel />
			</div>
  		);
  	}
}
// ========================================

ReactDOM.render(
	<Navigator />,
	document.getElementById('root')
);

function calculateWinner(squares) {
	const lines = [
		[0, 1, 2],
		[3, 4, 5],
		[6, 7, 8],
		[0, 3, 6],
		[1, 4, 7],
		[2, 5, 8],
		[0, 4, 8],
		[2, 4, 6],
	];
	for (let i = 0; i < lines.length; i++) {
		const [a, b, c] = lines[i];
		if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
			return squares[a];
		}
	}
	return null;
}
