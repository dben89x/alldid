import React from 'react';
import Barbers from './Barbers';
import FeaturedBarber from './FeaturedBarber';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const { featured, barbers, profileId } = this.props;

		return (
			<div id="barber-container" className='col-md-10'>
				<FeaturedBarber featured={ featured } profileId={ profileId } links={true}/>
				<Barbers barbers={ barbers } profileId={ profileId } links={true}/>
			</div>
		);
	}
}
