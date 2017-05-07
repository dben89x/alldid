import React from 'react';
// import moment from 'moment';
import _ from 'underscore';
// import InfiniteCalendar from 'react-infinite-calendar';

export default class Calendar extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
		}
	}

	render () {
		var today = new Date();
		var lastWeek = new Date(today.getFullYear(), today.getMonth(), today.getDate() - 7);

		return (
			<div>
				<InfiniteCalendar
					width={400}
					height={600}
					selected={today}
					disabledDays={[0,6]}
					minDate={lastWeek}
				/>
			</div>
		);
	}
}
