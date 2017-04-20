import React from 'react';
import Barbers from './Barbers';
import FeaturedBarber from './FeaturedBarber';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		return (
			<div id="barber-container" className='col-md-10'>
				<FeaturedBarber featured={this.props.featured}/>
				<Barbers barbers={this.props.barbers} profileId={this.props.profileId} links={true}/>
			</div>
		);
	}
}
