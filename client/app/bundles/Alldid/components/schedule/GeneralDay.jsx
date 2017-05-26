import React from 'react';
import fc from 'fullcalendar';
import _ from 'underscore';
import Select from 'react-select';
import moment from 'moment';

export default class GeneralDay extends React.Component {
	constructor(props){
		super(props)
		this.state = {
			startTime: 0,
			endTime: 0,
		}
	}

	handleStartTimeChange =(day, startOrEnd, data)=> {
		this.setState({startTime: data.value}, ()=> {
			this.props.handleDayChange(day, startOrEnd, this.state.startTime)
		})
	}

	handleEndTimeChange =(day, startOrEnd, data)=> {
		this.setState({endTime: data.value}, ()=> {
			this.props.handleDayChange(day, startOrEnd, this.state.endTime)
		})
	}

	render () {
		const { day } = this.props;

		var hours = []
		for (var i = 1; i < 24; i++ ) { hours.push(i) }

		hours = hours.map( (h)=> {
			return {value: (h*100), label: (moment(String(h*100),"hmm").format("h:mm A")) }
		})

		return (
			<div className='day'>
				<div className='name'>{day.name}</div>
					<Select
						name={day.name}
						placeholder="Start time"
						options={hours}
						value={this.state.startTime}
						onChange={(e) => this.handleStartTimeChange(day.name, "start", e)}
					/>
					<Select
						name={day.name}
						placeholder="End time"
						options={hours}
						value={this.state.endTime}
						onChange={(e) => this.handleEndTimeChange(day.name, "end", e)}
					/>
			</div>
		);
	}
}
