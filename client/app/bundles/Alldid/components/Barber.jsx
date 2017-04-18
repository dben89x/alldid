import React from 'react';
import ClientSidebar from './ClientSidebar';
import BarberContainer from './BarberContainer';
import _ from 'underscore';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const { name, headline, location, price } = this.props.barber
		var priceString = ``
		_.times( price, () => priceString = `${priceString}<span class='fa fa-usd'/>` )
		const priceHtml = {__html: priceString}

		return (
			<div className='barber'>
				<div className='barber-avatar'>
					<div className='barber-image'/>
				</div>
				<div className='barber-details'>
					<div className='barber-name'>
						{name}
					</div>
					<div className='barber-location'>
						<span className='fa fa-map-marker'/>{location}
					</div>
					<div className='barber-price'>
						<span dangerouslySetInnerHTML={ priceHtml }/>
					</div>
					<div className='barber-headline'>
						{headline}
					</div>
				</div>
				<div className='skills-and-styles'>
					<div className='skills'>

					</div>
					<div className='styles'>
						
					</div>
				</div>
				<span className='barber-favorite fa fa-star-o'/>
			</div>
		);
	}
}
