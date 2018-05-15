import React, { Component } from 'react';
import { Menu } from 'semantic-ui-react';

class Header extends Component {
    state = {
		activeItem: 'Transactions'
	};

    onClickItem = (e, { name }) => {
        this.setState({ activeItem: name });
    };

    render() {
        const { activeItem } = this.state;

        return (
            <Menu>
                <Menu.Item
                name='Transactions'
                active={activeItem === 'Transactions'}
				onClick={this.onClickItem}
				href='/'
                />
                <Menu.Item
                name='Budgets'
                active={activeItem === 'Budgets'}
				onClick={this.onClickItem}
				href='/budgets'
                />
            </Menu>
        );
    }
}

export default Header;