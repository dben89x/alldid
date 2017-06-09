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

	componentDidMount() {
		var _this = this

		var day = moment(this.props.date).format('dddd')
		if (this.props.schedule[day].available) {
			$.ajax({
				url: `/events?date=${this.props.date}&barberId=${this.props.barber.id}`,
				method: 'GET',
				dataType: 'json',
				success: (data) => {
					var newEvents = data.map((d)=>{
						return { title: "Appointment", start: d.start_time, end: d.end_time}
					})
					_this.renderCalendar(_this.props, newEvents)
				}
			});
		} else {
			var start = this.props.schedule[day].start
			var end = this.props.schedule[day].end
			var date = this.props.date
			var events = [{
				title: `Unavailable on ${day}`,
				start: new Date(`${date.toDateString()} ${start/100}:${start%100}`),
				end: new Date(`${date.toDateString()} ${end/100}:${end%100}`)
			}]
			this.renderCalendar(this.props, events)
		}
	}

	componentWillReceiveProps(nextProps) {
		var day = moment(nextProps.date).format('dddd')
		if (nextProps.schedule[day].available) {
			$.ajax({
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
		} else {
			var start = nextProps.schedule[day].start
			var end = nextProps.schedule[day].end
			var date = nextProps.date
			console.log(date)
			var events = [{
				title: `Unavailable on ${day}`,
				start: new Date(`date ${start/100}:${start%100}`),
				end: new Date(`date ${end/100}:${end%100}`)
			}]
			this.renderCalendar(nextProps, events)
		}
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
		var day = moment(this.props.date).format('dddd')
		if (this.props.schedule[day].available) {
			var minutes = this.props.minutes
			var start = date.clone()
			var end = date.clone().add(minutes, 'minutes')
			this.setState({modalDate: date, modalStart: start, modalEnd: end}, () =>{
				this.setState({modalShow: true})
			})
		}
	}

	renderCalendar = (props, events) => {
		const windowHeight = window.innerHeight
		const startTime = `${parseInt(props.startTime/100)}:${props.startTime%100}:00`
		const endTime = `${parseInt(props.endTime/100)}:${props.endTime%100}:00`
		console.log(events)
		$('#calendar').fullCalendar('destroy')
		$('#calendar').fullCalendar({
			timezone: "local",
			events: events,
			defaultView: 'agendaDay',
			defaultDate: props.date,
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
				<div id="calendar" ref='calendar'></div>
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
