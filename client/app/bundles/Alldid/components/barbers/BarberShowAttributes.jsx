import React from 'react';
import Barber from './Barber';

export default class BarberShowAttributes extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		return (
			<div className='additionalAttributes'>
				{this.props.barber.bio}
			</div>
		);
	}
}
