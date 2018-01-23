import React from 'react';
import ReactDOM from 'react-dom';
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
		this.setCurrentAttraction = this.setCurrentAttraction.bind(this);
		this.state = {
			attractions: []
		}
	}
	componentDidMount() {
		let self = this;
		let attractions = {};
		fetch("/api/attractions").then(function(res) {
				return res.json()
			}).then(function(result) {
				result.forEach(function(val) {
					attractions[val._id] = val;
				});
				self.setState({
					attractions: attractions
				});

        	})
	}
	setCurrentAttraction(attraction_id) {
		this.setState({
			current: attraction_id
		})
	}
	render() {
		return (
			<div className="container control-panel">
				<div className="data-panels">
					<SettingsPanel />
					<InfoPanel attractions={this.state.attractions} current={this.state.current}/>
				</div>
				<div className="drag-panels">
					<AttractionsPanel attractions={this.state.attractions} setCurrentAttraction={this.setCurrentAttraction} />
					<InterestsPanel attractions={this.state.attractions} setCurrentAttraction={this.setCurrentAttraction} />
				</div>
			</div>
		)
	}
}
class Navigator extends React.Component {
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
