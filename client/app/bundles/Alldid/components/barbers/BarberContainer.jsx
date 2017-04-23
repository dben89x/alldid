import React from 'react';
import Barbers from './Barbers';
import FeaturedBarber from './FeaturedBarber';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const { featured, barbers, profileId } = this.props;

		const featuredBarber = featured ? <FeaturedBarber featured={ featured }/> : null
		return (
			<div id="barber-container" className='col-md-10'>
				{ featuredBarber }
				<Barbers barbers={ barbers } profileId={ profileId } links={true}/>
			</div>
		);
	}
}
