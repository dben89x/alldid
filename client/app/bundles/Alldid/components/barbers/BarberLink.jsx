import React from 'react';
import Barber from './Barber';

export default class BarberLink extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		return (
			<a className='barber-link' href={`/barbers/${this.props.barber.id}`}>
				<Barber barber={this.props.barber} key={this.props.barber.id} profileId={this.props.profileId}/>
			</a>
		);
	}
}
