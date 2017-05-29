import React from 'react';
import Select from 'react-select';
import ServiceTag from './ServiceTag';
import _ from 'underscore';

export default class UserServices extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
			xhr: null,
			user_services: this.props.user_services,
			showResultsLink: null
		}
	}

	handleServicesChange =(data)=> {
		const { barberId } = this.props
		this.setState({ user_services: data}, ()=>{
			this.state.xhr ? this.state.xhr.abort() : null;
			this.state.xhr = $.ajax({
				url: `/barber_services`,
				method: 'POST',
				data: {
					"user_id": barberId,
					"services": this.state.user_services,
				},
				dataType: 'json',
				success: (newData) => { console.log("Great success!") }
			});
		});
	}

	render () {
		// const services = this.props.all_services.map( function(service) {
		// 	return <ServiceTag name={service.name} key={service.id} title=''/>
		// });
		const services = this.props.all_services.map( function(service) {
			return {value: service, label: (service.charAt(0).toUpperCase() + service.slice(1))}
		});
		return (
			<div className='user-services'>
				<Select
					name="profile[services]"
					id="profile_services"
					multi={true}
					joinValues={true}
					options={services}
					value={(this.state.user_services === undefined || this.state.user_services[0] === "") ? null : this.state.user_services}
					onChange={this.handleServicesChange}
				/>
			</div>
		);
	}
}
