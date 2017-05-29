import React from 'react';
import ClientSidebar from './ClientSidebar';
import BarberContainer from './BarberContainer';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const { barbers, featured, profileId, style, userLocation, userAvatar, signedIn } = this.props;
		return (
			<div id="search-container">
				<ClientSidebar style={style} userLocation={userLocation} avatar={userAvatar} signedIn={signedIn}/>
				<BarberContainer barbers={barbers} featured={featured} profileId={profileId}/>
			</div>
		);
	}
}
