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
	}

	handleFavorite() {
		const profile_id = this.props.profile_id
		this.state.xhr = $.ajax({
			url: `/user_favorites`,
			method: 'POST',
			success: (newData) => {
				this.setState({ user_styles: newData }, function(){
					this.setState({ showResultsLink: (this.state.xhr !== null || this.state.xhr.readyState === 4)})
				});
			}
		});
	}

	render () {
		const { name, headline, location, price, styles, services } = this.props.barber

		var priceString = ``
		_.times( price, () => priceString = `${priceString}<span class='fa fa-usd'/>` )
		const priceHtml = {__html: priceString}

		const barber_styles = styles.map( (style) => <StyleTag name={style} key={Math.random(100)}/>)
		const barber_services = services.map( (service) => <ServiceTag name={service} key={Math.random(100)}/>)

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
				<div className='services-and-styles'>
					<div className='services'>
						{barber_services}
					</div>
					<div className='styles'>
						{barber_styles}
					</div>
				</div>
				<span className='barber-favorite fa fa-star-o' onClick={this.handleFavorite}/>
			</div>
		);
	}
}
