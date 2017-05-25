import React from 'react';
import ClientStyle from './ClientStyle';
import BarberStyle from './BarberStyle';
import _ from 'underscore';

export default class UserStyles extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
			xhr: null,
			showResultsLink: null
		}
	}

	render () {
		const { styles, profileId, userType, userId } = this.props
		var props = this.props

		var userStyles
		if (userType === "Barber") {
			userStyles = styles.map( function(style) {
				var selected = false
				for (var i = 0; i < props.barberStyles.length; i++) {
					if (props.barberStyles[i].style_id === style.id) {
						selected = true
						break;
					}
				}
				return <BarberStyle style={style} key={style.id} selected={selected} userId={userId}/>
			});
		} else if (userType === "Client") {
			userStyles = styles.map( function(style) {
				var selected = props.clientStyle.id === style.id
				return <ClientStyle style={style} key={style.id} selected={selected} profileId={profileId}/>
			});
		}


		return (
			<div className='user-styles'>
				{ userStyles }
			</div>
		);
	}
}
