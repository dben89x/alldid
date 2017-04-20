import React from 'react';
import Barber from './Barber';
import BarberLink from './BarberLink';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const { barbers, links, profileId } = this.props;
		var newbarbers;
		if (links) {
			newbarbers = barbers.map( (barber) => <BarberLink barber={barber} key={barber.id} profileId={profileId} links={links}/>)
		} else {
			newbarbers = barbers.map( (barber) => <Barber barber={barber} key={barber.id} profileId={profileId} links={links}/>)
		}

		return (
			<div id="barbers">
				{newbarbers}
			</div>
		);
	}
}
