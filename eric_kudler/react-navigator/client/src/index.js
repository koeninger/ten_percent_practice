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
		this.state = {
			current_attraction: null,
			attractions: [
				{
					id: 0,
					name: 'Stich\'s Great Escape',
					description: 'Catch Stitch at this “theater-in-the-round” experience that’s a treat for your senses—available seasonally throughout the year!'

				},
				{
					id: 1,
					name: 'Mickey\'s PhillharMagic',
					description: 'Get swept away in the magic of Disney animation in this 3D movie musical starring many favorite Disney characters.'
				},
				{
					id: 2,
					name: 'Seven Dwarfs Mine Train',
					description: 'Race through the diamond mine from Snow White and the Seven Dwarfs on a swaying family coaster.'
				}, 
				{
					id: 3,
					name: 'Pirates of the Carribean',
					description: 'Set sail on a swashbuckling voyage to a long-forgotten time and place when pirates and privateers ruled the seas.'
				},
				{
					id: 4,
					name: 'Haunted Mansion',
					description: 'Embark on a spine-tingling tour through an eerie haunted estate, home to ghosts, ghouls and supernatural surprises.'
				}, 
				{
					id: 5,
					name: 'Jungle Cruise',
					description: 'Set sail for high adventure on a scenic boat tour of the most exotic and exciting rivers across Asia, Africa and South America.'
				}, 
				{
					id: 6,
					name: 'Space Mountain',
					description: 'Blast off on a rip-roaring rocket through the darkest reaches of outer space on this roller-coaster-type ride in the dark.'
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
