import React from 'react';
import BarberLink from './BarberLink';

export default class FeaturedBarber extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		return (
			<div id='featured-barber'>
				<BarberLink barber={this.props.featured} key={barber.id} profileId={profileId} links={links}/>
			</div>
		);
	}
}
