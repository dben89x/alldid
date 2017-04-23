import React from 'react';
import Barber from './Barber';
import ServiceTag from '../forms/ServiceTag';

export default class BarberShowAttributes extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const { services, bio } = this.props.barber
		const barberServices = services.map( (service) => <ServiceTag name={service} key={Math.random(100)}/>)

		return (
			<div className='additionalAttributes'>
				<div className='services-header'>Services:</div>
				<div className='services'>
					{barberServices}
				</div>
				<div className='barber-bio'>{bio}</div>
			</div>
		);
	}
}
