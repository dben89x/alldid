import React from 'react';
import moment from 'moment';
import fc from 'fullcalendar';
import AppointmentModal from './AppointmentModal';


export default class DailyEvents extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
			modalShow: false,
			modalDate: 0
		}
	}

	componentDidUpdate(prevProps, prevState) {
		$('#calendar').fullCalendar('gotoDate', this.props.date);
		// if (prevProps.data !== this.props.data) {
		// 	this.chart = c3.load({
		// 		data: this.props.data
		// 	});
		// }
	}

	componentDidMount() {
		this.renderCalendar()
	}

	renderCalendar = () => {
		const windowHeight = window.innerHeight

		$('#calendar').fullCalendar({
			timezone: "local",
			defaultView: 'agendaDay',
			defaultDate: this.props.date,
			dayClick: (date, jsEvent, view) => {
				this.setState({modalDate: date}, () =>{
					console.log(`Modal date: ${date}`)
					this.setState({modalShow: true})
				})
				console.log('Clicked on: ' + date)
			},
			header: false,
			columnFormat: 'dddd, MMM D',
			height: windowHeight,
			minTime: '06:00:00',
			maxTime: '23:00:00',
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
					barber={this.props.barber}
					client={this.props.client}
					services={this.props.services}
					styles={this.props.styles}
					/>
			</div>
		);
	}
}
