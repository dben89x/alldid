import React from 'react';
import Barber from './Barber';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		var count = 0;
		const barbers = this.props.barbers.map( function(barber) {
			count = count + 1;
			return <Barber barber={barber} key={count} title=''/>
		});
		return (
			<div id="barbers">
				{barbers}
			</div>
		);
	}
}
