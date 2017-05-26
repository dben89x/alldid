import React from 'react';
import StyleTag from '../forms/StyleTag';
import BarberShowAttributes from './BarberShowAttributes';
import _ from 'underscore';

export default class SearchContainer extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
			favorite: this.props.barber.favorite,
			favoriteClass: `${this.props.barber.favorite ? 'fa-star faved' : 'fa-star-o'}`,
			xhr: null,
		}
	}

	handleSocialClick = (event) => {
		event.preventDefault();
	}

	handleFavorite = (event) => {
		event.preventDefault();
		const profileId = this.props.profileId
		const barberId = this.props.barber.id
		const target = event.target

		if (this.state.favorite) {
			this.state.xhr = $.ajax({
				url: `/delete_favorite`,
				method: 'POST',
				data: {
					"user_id": barberId,
					"profile_id": profileId
				},
				dataType: 'json',
				success: (newData) => { this.toggleFaStar(target) }
			});
		} else {
			this.state.xhr = $.ajax({
				url: `/favorites`,
				method: 'POST',
				data: {
					"favorite": {
						"user_id": barberId,
						"profile_id": profileId
					}
				},
				dataType: 'json',
				success: (newData) => { this.toggleFaStar(target) }
			});
		}
	}

	toggleFaStar = (target) => {
		$(target).toggleClass('fa-star')
		$(target).toggleClass('fa-star-o')
		$(target).toggleClass('faved')
	}

	render () {
		const { id, name, headline, location, services, avatar, endorsements } = this.props.barber

		var priceString = ``
		_.times( price, () => priceString = `${priceString}<span class='fa fa-usd'/>` )
		const priceHtml = {__html: priceString}

		const barberStyles = this.props.barber.barberStyles.map( (barberStyle) => <StyleTag barberStyle={barberStyle} key={barberStyle.id} endorsements={barberStyle.endorsements}/>)
		const additionalAttributes = this.props.links === undefined ? null : <BarberShowAttributes barber={this.props.barber}/>
	// var avatarStyle = { backgroundImage: `url(${avatar})` };

		const bookLink = this.props.links === undefined ? null : <div className='barber-book'><a href={`/calendar?barber=${id}`} className="brand-btn small-btn light-brand-btn">Book Appointment</a></div>

		return (
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
						<div className='barber-headline'>
							{headline}
						</div>
						{ bookLink }
					</div>

					<div className='services-and-styles'>
						<div className='styles-header'>Styles and Endorsements:</div>
						<div className='styles'>
							{barberStyles}
						</div>

						{ additionalAttributes }

					</div>

				</div>

				<span className={`barber-favorite fa ${this.state.favoriteClass}`} onClick={this.handleFavorite}/>
				<div className={'social-icons'}>
					<span className='fa fa-facebook-square' onClick={this.handleSocialClick} value={'/'}/>
					<span className='fa fa-twitter-square' onClick={this.handleSocialClick} value={'/'}/>
					<span className='fa fa-instagram' onClick={this.handleSocialClick} value={'/'}/>
				</div>
			</div>
		);
	}
}
