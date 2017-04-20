import React from 'react';
import ClientSidebar from './ClientSidebar';
import BarberContainer from './BarberContainer';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const { barbers, featured, profileId, style, userLocation, price } = this.props;
		return (
			<div id="search-container">
				<ClientSidebar style={style} userLocation={userLocation} price={price}/>
				<BarberContainer barbers={barbers} featured={featured} profileId={profileId}/>
			</div>
		);
	}
}
