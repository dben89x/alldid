import React from 'react';
import moment from 'moment';
import fc from 'fullcalendar';
import AppointmentModal from './AppointmentModal';

export default class DailyEvents extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
			modalShow: false,
			modalStart: 0,
			modalEnd: 0,
			modalDate: 0,
			events: [],
			xhr: null,
			loading: false
		}
	}

	componentDidUpdate(prevProps, prevState) {
		$('#calendar').fullCalendar('gotoDate', this.props.date);
		// if (prevState !== this.state) {}
	}

	componentDidMount() {
		// this.renderCalendar()
	}

	componentWillMount() {
		this.setState({loading: true})
		this.state.xhr = $.ajax({
			url: `/events?date=${this.props.date}&barberId=${this.props.barber.id}`,
			method: 'GET',
			dataType: 'json',
			success: (data) => {
				var newEvents = data.map((d)=>{
					return { title: "Appointment", start: d.start_time, end: d.end_time}
				})
				console.log(JSON.stringify(newEvents))
				this.setState({events: this.state.events.concat(newEvents)}, ()=>{
					this.renderCalendar()
					this.setState({loading: false})
				})
			}
		});
	}

	updateEvents =(json)=> {
		this.renderNewEvent(json)
		this.addEventToState(json)
		this.setState({modalShow: false})
	}

	renderNewEvent =(json)=> {
		$('#calendar').fullCalendar( 'renderEvent', this.eventJson(json) )
	}

	addEventToState =(json)=> {
		this.setState({events: this.state.events.concat( this.eventJson(json) ) })
	}

	eventJson =(json)=> {
		return {
			title: "Appointment",
			start: json.start_time,
			end: json.end_time
		}
	}

	updateModalProps =(date)=> {
		var minutes = this.props.minutes
		var start = date.clone()
		var end = date.clone().add(minutes, 'minutes')
		this.setState({modalDate: date, modalStart: start, modalEnd: end}, () =>{
			this.setState({modalShow: true})
		})
	}

	renderCalendar = () => {
		const windowHeight = window.innerHeight
		$('#calendar').fullCalendar({
			timezone: "local",
			events: this.state.events,
			defaultView: 'agendaDay',
			defaultDate: this.props.date,
			slotDuration: '00:15:00',
			eventColor: 'rgba(94, 21, 19, 0.7)',
			dayClick: (date, jsEvent, view) => {this.updateModalProps(date)},
			header: false,
			columnFormat: 'dddd, MMM D',
			height: windowHeight,
			minTime: this.props.startTime,
			maxTime: this.props.endTime,
			allDayDefault: false,
			allDaySlot: false
		});
	}

	render () {
		let modalClose = () => this.setState({ modalShow: false });

		return (
			<div>
				<div id="calendar"></div>
				<AppointmentModal
					show={this.state.modalShow}
					onHide={modalClose}
					date={this.state.modalDate}
					start={this.state.modalStart}
					end={this.state.modalEnd}
					barber={this.props.barber}
					client={this.props.client}
					services={this.props.services}
					styles={this.props.styles}
					rate={this.props.rate}
					updateEvents={this.updateEvents}
					/>
			</div>
		);
	}
}
