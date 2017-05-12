import React from 'react';
import moment from 'moment';
import fc from 'fullcalendar';

export default class DailyEvents extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
		}
	}

	componentDidUpdate(prevProps, prevState) {
		console.log(this.props.date)
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
			defaultView: 'agendaDay',
			defaultDate: this.props.date,
			dayClick: (date, jsEvent, view) => {
				console.log('Clicked on: ' + date.format())
				console.log('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY)
				console.log('Current view: ' + view.name)
			},
			header: false,
			height: windowHeight,
			minTime: '06:00:00',
			maxTime: '22:00:00',
			allDayDefault: false,
			allDaySlot: false
		});
	}

	render () {

		return (
			<div id="calendar"></div>
		);
	}
}
