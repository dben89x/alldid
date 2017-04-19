import React from 'react';
import ClientSidebar from './ClientSidebar';
import BarberContainer from './BarberContainer';
import StyleTag from '../forms/StyleTag';
import ServiceTag from '../forms/ServiceTag';
import _ from 'underscore';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
			xhr: null,
		}
		this.handleFavorite = this.handleFavorite.bind(this)
	}

	handleFavorite(event) {
		const { profile_id, barber_id } = this.props
		const target = event.target
		this.state.xhr = $.ajax({
			url: `/user_favorites`,
			method: 'POST',
			data: { "favorite": {
					"user_id": barber_id,
					"profile_id": profile_id
				}
			},
			dataType: 'json',
			success: (newData) => {
				$(target).toggleClass('fa-star')
				$(target).toggleClass('fa-star-o')
				$(target).toggleClass('faved')

			}
		});
		event.preventDefault();
	}

	render () {
		const { id, name, headline, location, price, styles, services, avatar } = this.props.barber

		var priceString = ``
		_.times( price, () => priceString = `${priceString}<span class='fa fa-usd'/>` )
		const priceHtml = {__html: priceString}

		const barber_styles = styles.map( (style) => <StyleTag name={style} key={Math.random(100)}/>)
		const barber_services = services.map( (service) => <ServiceTag name={service} key={Math.random(100)}/>)
		// var avatarStyle = { backgroundImage: `url(${avatar})` };

		return (
			<a href={`/barbers/${id}`}>
				<div className='barber'>
					<div className='barber-avatar'>
						<div className='barber-image'/>
					</div>
					<div className='barber-details-container'>
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
						<div className='services-and-styles'>
							<div className='styles-header'>Styles:</div>
							<div className='styles'>
								{barber_styles}
							</div>

							<div className='services-header'>Services:</div>
							<div className='services'>
								{barber_services}
							</div>
						</div>
					</div>

					<span className='barber-favorite fa fa-star-o' onClick={this.handleFavorite}/>
				</div>
			</a>
		);
	}
}
