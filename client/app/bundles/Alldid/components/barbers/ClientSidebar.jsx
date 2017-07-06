import React from 'react';
import _ from 'underscore';

export default class ClientSidebar extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const { style, userLocation, avatar, signedIn } = this.props;
		const styleString = style ? style.toUpperCase() : null
		const locationString = userLocation ? userLocation.toUpperCase() : null

		// Pricing
		// var priceString = ``
		// _.times( price, () => priceString = `${priceString}<span class='fa fa-usd'/>` )
		// const priceHtml = {__html: priceString}

		// <div className='price'>
		// 	<h4>Preferred Price:</h4>
		// 	<span dangerouslySetInnerHTML= { priceHtml } />
		// 	<a href='/profile'>
		// 		<span className='fa fa-pencil'/>
		// 	</a>
		// </div>

		// Location
		// <div className='location'>
		// 	<h4>Your Location:</h4>
		// 	<span>{ locationString }</span>
		// 	<a href='/profile'>
		// 		<span className='fa fa-pencil'/>
		// 	</a>
		// </div>

		return (
			<div id='client-sidebar-container' className='col-md-2'>
				<div className='user-avatar'>
					<img src={avatar} className='user-avatar-img'/>
				</div>
				<div className='current-style'>
					<h4>Preferred Style:</h4>
					<span>{ styleString }</span>
					<a href='/profile'>
						<span className='fa fa-pencil'/>
					</a>
				</div>

			</div>
		);
	}
}
