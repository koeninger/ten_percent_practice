import React from 'react';
import ReactDOM from 'react-dom';
import { Row, Col } from 'react-bootstrap';
import { Navbar, Nav, NavItem, NavDropdown, MenuItem} from 'react-bootstrap';
import InterestsPanel from './common/panels/InterestsPanel';
import SettingsPanel from './common/panels/SettingsPanel';
import AttractionsPanel  from './common/panels/AttractionsPanel';
import InfoPanel from './common/panels/InfoPanel';

import './index.css';
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap/dist/css/bootstrap-theme.css';

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
						<InfoPanel attractions={this.state.attractions} current={this.state.current}/>
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
