import React from 'react';
import Barber from './Barber';

export default class FeaturedBarber extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		return (
			<div id='featured-barber'>
				<Barber barber={this.props.featured} title="Your Perfect Barber"/>
			</div>
		);
	}
}
