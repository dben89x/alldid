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
		this.renderCalendar(this.props, this.state.events)
		$('#calendar').fullCalendar('gotoDate', this.props.date);
		// if (prevState !== this.state) {}
	}

	componentWillMount() {
		// console.log('mounted')
		// console.log(JSON.stringify(this.props))
		// this.renderCalendar(this.props, this.state.events)
		// $('#calendar').fullCalendar('render')
	}

	componentDidMount() {
		// this.renderCalendar(this.props, this.state.events)
		// console.log($('#calendar'))
	}

	componentWillReceiveProps(nextProps) {
		console.log('received new props')
		console.log($('#calendar').fullCalendar())
		this.setState({loading: true})
		this.state.xhr = $.ajax({
			url: `/events?date=${nextProps.date}&barberId=${nextProps.barber.id}`,
			method: 'GET',
			dataType: 'json',
			success: (data) => {
				var newEvents = data.map((d)=>{
					return { title: "Appointment", start: d.start_time, end: d.end_time}
				})
				this.renderCalendar(nextProps, newEvents)
			}
		});
	}

	updateEvents =(json)=> {
		this.renderNewEvent(json)
		this.setState({modalShow: false})
	}

	renderNewEvent =(json)=> {
		$('#calendar').fullCalendar( 'renderEvent', this.eventJson(json) )
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

	renderCalendar = (nextProps, events) => {
		const windowHeight = window.innerHeight
		const startTime = `${parseInt(nextProps.startTime/100)}:${nextProps.startTime%100}:00`
		const endTime = `${parseInt(nextProps.endTime/100)}:${nextProps.endTime%100}:00`

		console.log('in calendar render')
		console.log(JSON.stringify(events))

		$('#calendar').fullCalendar('destroy')
		$('#calendar').fullCalendar({
			timezone: "local",
			events: events,
			defaultView: 'agendaDay',
			defaultDate: nextProps.date,
			slotDuration: '00:15:00',
			eventColor: 'rgba(94, 21, 19, 0.7)',
			dayClick: (date, jsEvent, view) => {this.updateModalProps(date)},
			header: false,
			columnFormat: 'dddd, MMM D',
			height: windowHeight,
			minTime: startTime,
			maxTime: endTime,
			allDayDefault: false,
			allDaySlot: false
		});
		$('#calendar').fullCalendar('render')
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
