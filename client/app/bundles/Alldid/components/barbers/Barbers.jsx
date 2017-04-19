import React from 'react';
import Barber from './Barber';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		var count = 0;
		const barbers = this.props.barbers.map( (barber) => <Barber barber={barber} key={barber.id}/>)
		
		return (
			<div id="barbers">
				{barbers}
			</div>
		);
	}
}
