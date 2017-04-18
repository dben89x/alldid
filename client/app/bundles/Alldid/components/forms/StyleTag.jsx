import React from 'react';
import _ from 'underscore';

export default class StyleTag extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		return (
			<div className='style-tag light-tag'>
				{this.props.name}
				<br/>
			</div>
		);
	}
}
