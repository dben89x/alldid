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
				"Sunday": {"start": 0, "end": 0},
				"Monday": {"start": 0, "end": 0},
				"Tuesday": {"start": 0, "end": 0},
				"Wednesday": {"start": 0, "end": 0},
				"Thursday": {"start": 0, "end": 0},
				"Friday": {"start": 0, "end": 0},
				"Saturday": {"start": 0, "end": 0}
			}
		}
		this.state = schedule
	}

	handleDayChange =(day, startOrEnd, time)=> {
		if (startOrEnd === "start") {
			var endTime = this.state[day].end
			this.setState({[day]: {"start": time, "end": endTime} }, ()=>{
				console.log(this.state)
			})
		} else if (startOrEnd === "end") {
			var startTime = this.state[day].start
			this.setState({[day]: {"start": startTime, "end": time} }, ()=>{
				console.log(this.state)
			})
		}
	}

	submitSchedule =(event)=> {
		event.preventDefault()

		var thisState = this.state
		console.log(JSON.stringify(thisState))

		$('.updateScheduleSpan').removeClass('fa-check').addClass('fa-spin fa-spinner')
		this.state.xhr = $.ajax({
			url: `/schedules`,
			method: 'post',
			data: { thisState },
			dataType: 'json',
			success: () => { $('.updateScheduleSpan').removeClass('fa-spin fa-spinner').addClass('fa-check') }
		});
	}

	render () {
		const { barberId, days } = this.props
		const sortedDays = _.sortBy(days, (day)=> day.id)
		const dayComponents = sortedDays.map( (day) =>
			<GeneralDay key={day.id}
				day={day}
				handleDayChange={(day, startOrEnd, time) => this.handleDayChange(day, startOrEnd, time) } />
		)

		return (
			<div className='schedule'>
				Set your normal hours:
				{dayComponents}
				<button className='brand-btn light-brand-btn med-btn' onClick={this.submitSchedule}>Save Schedule<span className='fa updateScheduleSpan'/></button>
			</div>
		);
	}
}
