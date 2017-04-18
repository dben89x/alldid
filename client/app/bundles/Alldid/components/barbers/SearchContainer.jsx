import React from 'react';
import ClientSidebar from './ClientSidebar';
import BarberContainer from './BarberContainer';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		return (
			<div id="search-container">
				<ClientSidebar/>
				<BarberContainer barbers={this.props.barbers} featured={this.props.featured}/>
			</div>
		);
	}
}
