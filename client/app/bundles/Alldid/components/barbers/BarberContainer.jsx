import React from 'react';
import Barbers from './Barbers';
import FeaturedBarber from './FeaturedBarber';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		return (
			<div id="barber-container" className='col-md-9'>
				<FeaturedBarber featured={this.props.featured}/>
				<Barbers barbers={this.props.barbers}/>
			</div>
		);
	}
}
