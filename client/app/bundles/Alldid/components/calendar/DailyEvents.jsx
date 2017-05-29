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
		}
	}

	componentDidUpdate(prevProps, prevState) {
		$('#calendar').fullCalendar('gotoDate', this.props.date);
		// if (prevState !== this.state) {
		// }
	}

	componentDidMount() {
		this.renderCalendar()
	}

	updateModalProps =(date)=> {
		var minutes = this.props.barber.minutes
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
			defaultView: 'agendaDay',
			defaultDate: this.props.date,
			slotDuration: '00:15:00',
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
					/>
			</div>
		);
	}
}
