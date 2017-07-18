import React from 'react';
import BarberLink from './BarberLink';

export default class FeaturedBarber extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const { featured, profileId } = this.props;

		return (
			<div id='featured-barber'>
				<BarberLink barber={featured} profileId={profileId} links={true}/>
			</div>
		);
	}
}
