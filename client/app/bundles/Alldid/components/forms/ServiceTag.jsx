import React from 'react';
import _ from 'underscore';

export default class ServiceTag extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		return (
			<div className='service-tag dark-tag'>
				{this.props.name}
				<br/>
			</div>
		);
	}
}
