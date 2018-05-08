import React, { Component } from 'react';
import { Menu } from 'semantic-ui-react';

class Header extends Component {
    state = {};

    onClickItem = (e, { name }) => {
        this.setState({ activeItem: name });
    };

    render() {
        const { activeItem } = this.state;

        return (
            <Menu>
                <Menu.Item
                name='Accounts'
                active={activeItem === 'Accounts'}
                onClick={this.onClickItem}
                />
                <Menu.Item
                name='Budgets'
                active={activeItem === 'Budgets'}
                onClick={this.onClickItem}
                />
            </Menu>
        );
    }
}

export default Header;