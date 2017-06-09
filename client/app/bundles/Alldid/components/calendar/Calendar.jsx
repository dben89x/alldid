import React from 'react';
import _ from 'underscore';
import InfiniteCalendar, {withDateSelection} from 'react-infinite-calendar';
import DailyEvents from './DailyEvents';
import $ from 'jquery';
// import css from './ric.scss';

export default class Calendar extends React.Component {
	constructor(props) {
		super(props)
		const thisDate = new Date()
		var day = moment(thisDate).format('dddd')
		var start = this.props.schedule[day].start
		var end = this.props.schedule[day].end

		this.state = {
			fcDate: thisDate,
			fcStart: start,
			fcEnd: end,
			selectedDay: new Date(),
			events: []
		}
		console.log(JSON.stringify(this.state))
	}

	updateDailyEvents =(date)=> {
		var day = moment(date).format('dddd')
		var start = this.props.schedule[day].start
		var end = this.props.schedule[day].end

		this.setState({fcDate: date, fcStart: start, fcEnd: end, selectedDay: date})
	}

	render () {
		const windowWidth = window.innerWidth
		const windowHeight = window.innerHeight

		const navbarHeight = 58
		const footerHeight = 80

		const calWeekdaysHeight = 49

		if (windowWidth >= 800) {
			var calWidth = 400
			var calHeight = windowHeight - footerHeight - navbarHeight
			var showHeader = true
		} else {
			var calWidth = windowWidth
			var calHeight = (windowHeight - navbarHeight - footerHeight - calWeekdaysHeight)/2
			var showHeader = false
		}
		var today = new Date();
		var lastWeek = new Date(today.getFullYear(), today.getMonth(), today.getDate() - 7);

		return (
			<div className='react-calendar-container'>
				<div className='react-calendar'>
					<InfiniteCalendar
						width={calWidth}
						height={calHeight}
						selected={today}
						minDate={lastWeek}
						disabledDays={this.props.disabledDays}
						displayOptions={{
							showHeader: showHeader
						}}
						selected={this.state.selectedDay}
						onSelect={date => {this.updateDailyEvents(date)}}
						theme={{
							floatingNav: {
								background: 'rgba(25, 88, 108, 0.9)',
								chevron: '#FFA726',
								color: '#FFF',
							},
							headerColor: 'rgba(25, 88, 108, 0.8)',
							selectionColor: 'rgba(94, 21, 19, 1)',
							textColor: {
								active: '#FFF',
								default: '#333',
							},
							weekdayColor: 'rgba(25, 88, 108, 0.6)',
						}}
						/>
				</div>
				<DailyEvents
					calWidth={calWidth}
					calHeight={calHeight}
					date={this.state.fcDate}
					barber={this.props.barber}
					client={this.props.client}
					services={this.props.services}
					styles={this.props.styles}
					schedule={this.props.schedule}
					startTime={this.state.fcStart}
					endTime={this.state.fcEnd}
					minutes={this.props.minutes}
					rate={this.props.rate}
					events={this.state.events}
					/>
			</div>
		);
	}
}
