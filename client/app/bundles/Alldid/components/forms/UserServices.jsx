import React from 'react';
import ServiceTag from './ServiceTag';
import _ from 'underscore';

export default class UserServices extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const services = this.props.services.map( function(service) {
			return <ServiceTag name={service.name} key={service.id} title=''/>
		});
		return (
			<div className='user-services'>
				{services}
			</div>
		);
	}
}
