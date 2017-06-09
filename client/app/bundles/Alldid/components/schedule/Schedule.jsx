import React from 'react';
import _ from 'underscore';
import GeneralDay from './GeneralDay';

export default class Schedule extends React.Component {
	constructor(props) {
		super(props)

		var schedule
		if (this.props.schedule !== null) {
			schedule = JSON.parse(this.props.schedule.json)
		} else {
			schedule = {
				"Sunday": {"start": 0, "end": 0, "available": true},
				"Monday": {"start": 0, "end": 0, "available": true},
				"Tuesday": {"start": 0, "end": 0, "available": true},
				"Wednesday": {"start": 0, "end": 0, "available": true},
				"Thursday": {"start": 0, "end": 0, "available": true},
				"Friday": {"start": 0, "end": 0, "available": true},
				"Saturday": {"start": 0, "end": 0, "available": true}
			}
		}
		this.state = schedule
	}

	handleDayChange =(day, startTime, endTime, available)=> {
		this.setState({[day]: {"start": startTime, "end": endTime, "available": available} })
	}

	submitSchedule =(event)=> {
		event.preventDefault()

		const {schedule} = this.props
		var thisState = this.state

		$('.updateScheduleSpan').removeClass('fa-check').addClass('fa-spin fa-spinner')
		$.ajax({
			url: `/schedules/${schedule.id}`,
			method: 'put',
			data: { "schedule": {
				"json": thisState
			} },
			dataType: 'json',
			success: () => { $('.updateScheduleSpan').removeClass('fa-spin fa-spinner').addClass('fa-check') }
		});
	}

	render () {
		const { barberId, days } = this.props
		const sortedDays = _.sortBy(days, (day)=> day.id)
		const thisState = this.state
		const dayComponents = sortedDays.map( (day) =>
			<GeneralDay key={day.id}
				startTime={this.state[day.name].start}
				endTime={this.state[day.name].end}
				available={this.state[day.name].available}
				day={day}
				handleDayChange={(day, startOrEnd, time, available) => this.handleDayChange(day, startOrEnd, time, available) }
			/>
		)

		return (
			<div className='schedule'>
				<h3>Set your normal hours:</h3>
				{dayComponents}
				<button className='brand-btn light-brand-btn med-btn' onClick={this.submitSchedule}>
					Save Schedule<span className='fa updateScheduleSpan'/>
				</button>
			</div>
		);
	}
}
