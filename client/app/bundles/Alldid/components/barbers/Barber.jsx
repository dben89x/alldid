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

	handleSocialClick = (event, linkName) => {
		event.preventDefault();
		var link = this.props.barber[linkName]
		window.open(link, '_blank')
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

	socialLink =(linkName)=> {
		if (String(this.props.barber[linkName]).includes(`${linkName}.com`)) {
			var className = linkName === 'instagram' ? `fa-${linkName}` : `fa-${linkName}-square`
			return <span className={`fa ${className}`} onClick={ (e)=> {this.handleSocialClick(e, linkName)} }/>
		}
	}

	render () {
		const { id, name, headline, location, services, avatar, endorsements, price, barbershop } = this.props.barber
		const { barber, links } = this.props
		var priceString = ``
		_.times( price, () => priceString = `${priceString}<span class='fa fa-usd'/>` )
		const priceHtml = {__html: priceString}

		const barberStyles = barber.barberStyles.map( (barberStyle) => <StyleTag barberStyle={barberStyle} key={barberStyle.id} endorsements={barberStyle.endorsements} links={links}/>)
		const additionalAttributes = links === undefined ? null : <BarberShowAttributes barber={this.props.barber}/>
	// var avatarStyle = { backgroundImage: `url(${avatar})` };

	// Temporarily removed book link 8/10/17
	// const bookLink = links === undefined ? null : <div className='barber-book'><a href={`/calendar?barber=${id}`} className="brand-btn small-btn light-brand-btn">Book Appointment</a></div>
		const bookLink = false
		var phone = ''
		if (this.props.phone){
			if (this.props.barber.phone) {
				var tel = `tel:${this.props.barber.phone}`
				phone = `
				<a class='barber-phone' href=${tel}>
					<span class='fa fa-phone'></span>
					${this.props.barber.phone}
					</a>
					`
			}
		}

	//
		const socialLinks = ['facebook', 'twitter', 'instagram'].map( (linkName)=> this.socialLink(linkName))

		return (
			<div className='barber'>
				<div className='barber-avatar'>
					<div className='barber-image'>
						<img src={avatar}/>
					</div>
				</div>

				<div className='barber-details-container'>
					<div className='barber-details'>
						<div className='barber-name'>
							{name}
						</div>
						<span dangerouslySetInnerHTML={ {__html: phone} }/>
						<div className='barber-location'>
							<span className='fa fa-map-marker'/>{location}
						</div>
						<div className='barber-price'>
							<span dangerouslySetInnerHTML={ priceHtml }/>
						</div>
						<div className='barber-headline'>
							{barbershop}
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
					{socialLinks}
				</div>
			</div>
		);
	}
}
