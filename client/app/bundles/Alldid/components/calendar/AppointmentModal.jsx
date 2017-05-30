import React from 'react';
import { Modal } from 'react-bootstrap';
import Select from 'react-select';
import moment from 'moment';

export default class AppointmentModal extends React.Component {
	constructor(props) {
		super(props)

		this.state = {
			startTime: this.props.start,
			endTime: this.props.end,
			services: [],
			style: '',
			notes: '',
			date: 0,
			xhr: null,
		}
	}

	componentWillReceiveProps(nextProps) {
		this.setState({ date: nextProps.date, startTime: nextProps.start, endTime: nextProps.end, services: [] })
	}

	handleSubmit = (event) => {
		event.preventDefault()

		const { client, barber } = this.props
		const { styleId, startTime, endTime, notes } = this.state

		this.state.xhr = $.ajax({
			url: `/events`,
			method: 'POST',
			data: { "event": {
				"client_id": client.id,
				"barber_id": barber.id,
				"style_id": styleId,
				"start_time": startTime,
				"end_time": endTime,
				"notes": notes
			} },
			dataType: 'json',
			success: (data) => {
				
			}
		});
	}

	handleInputChange =(event) => {
		const target = event.target;
		const value = target.value;
		const name = target.name;

		this.setState({[name]: value});
	}

	handleServicesChange = (name, data) => {
		this.setState({[name]: data});
		this.recalculateEndTime()
	}

	handleStyleChange = (name, data) => {
		this.setState({[name]: data});
	}

	recalculateEndTime =()=> {
		var end = this.state.endTime.add(this.props.minutes, 'minutes')
		this.setState({endTime: end})
	}

	render () {

		const { startTime, endTime, notes } = this.state

		const services = this.props.services.map( (service) => {
			return {value: service.id, label: (service.name.charAt(0).toUpperCase() + service.name.slice(1))}
		})

		const styles = this.props.styles.map( (style) => {
			return {value: style.id, label: (style.name.charAt(0).toUpperCase() + style.name.slice(1))}
		})

		// const startTimes =
		// get start of day integer and end of day integer, subtract start from end, divide by (60*30(or something)) and add these increments to each consecutive count

		// const endTimes =

		return (
			<Modal show={this.props.show} onHide={this.props.onHide} className='form light-form event-form'>

				<Modal.Header closeButton>
					<Modal.Title id="contained-modal-title-lg">{`Book Appointment for ${moment(this.state.date).format('h:mm A z [on] MMM D')}`}</Modal.Title>
				</Modal.Header>

				<Modal.Body className="event-modal-body">
					<form onSubmit={this.handleSubmit} >

						<div className='col-md-12'>

							<div>
								<div className='head'>Price:</div>
								<div className='text rate'>{`$${this.props.rate}`}</div>
							</div>

							<div>
								<div className='head'>Start Time:</div>
								<div className='text'>{`${moment(startTime).format('h:mm A')}`}</div>
							</div>

							<div>
								<div className='head'>End Time:</div>
								<div className='text'>{`${moment(endTime).format('h:mm A')}`}</div>
							</div>

							<label>
								Style:
								<br/>
								<Select name="Style"
									options={styles}
									value={this.state.style}
									onChange={(e) => this.handleStyleChange("style", e)} />
							</label>

							<label>
								Services:
								<br/>
								<Select name="Services"
									multi={true}
									joinValues={true}
									options={services}
									value={this.state.services[0] === "" ? null : this.state.services}
									onChange={(e) => this.handleServicesChange("services", e)}/>
							</label>

							<label className='col-md-12 col-sm-12'>
								Notes<br/>
								<textarea name="notes" rows='6' cols='5' value={notes} onChange={this.handleInputChange} className="light-input input"/>
							</label>

							<br/>
							<br/>

							<input type="submit" value="Book Appointment" className="brand-btn light-brand-btn med-btn"/>
						</div>

					</form>
				</Modal.Body>

				<Modal.Footer>
					<button onClick={this.props.onHide}>Close</button>
				</Modal.Footer>

			</Modal>
		);
	}
}
