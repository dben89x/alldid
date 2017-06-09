import React from 'react';
import _ from 'underscore';
import Select from 'react-select';
import moment from 'moment';

export default class GeneralDay extends React.Component {
	constructor(props){
		super(props)
		var available = (this.props.available === 'true' || this.props.available === true) ? true : false
		this.state = {
			startTime: this.props.startTime,
			endTime: this.props.endTime,
			available: available
		}
	}

	handleAvailableChange =(event)=> {
		const target = event.target
		this.setState({available: target.checked}, ()=> {
			const {startTime, endTime, available} = this.state
			this.props.handleDayChange(this.props.day.name, startTime, endTime, available)
		})
	}

	handleStartTimeChange =(data)=> {
		this.setState({startTime: data.value}, ()=> {
			const {startTime, endTime, available} = this.state
			this.props.handleDayChange(this.props.day.name, startTime, endTime, available)
		})
	}

	handleEndTimeChange =(data)=> {
		this.setState({endTime: data.value}, ()=> {
			const {startTime, endTime, available} = this.state
			this.props.handleDayChange(this.props.day.name, startTime, endTime, available)
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
				{String(this.state.available)}
				<label className='name'>
					{day.name}
					<input
						type='checkbox'
						checked={this.state.available}
						onChange={this.handleAvailableChange}
						/>
				</label>


				<label>
					<span className='day-select-label'>From</span>
					<Select
						name={day.name}
						placeholder="Start time"
						options={hours}
						value={this.state.startTime}
						onChange={this.handleStartTimeChange}
						disabled={!this.state.available}
						/>
				</label>

				<label>
					<span className='day-select-label'>To</span>
					<Select
						name={day.name}
						placeholder="End time"
						options={hours}
						value={this.state.endTime}
						onChange={this.handleEndTimeChange}
						disabled={!this.state.available}
						/>
				</label>
			</div>
		);
	}
}
