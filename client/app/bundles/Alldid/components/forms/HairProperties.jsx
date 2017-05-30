import React from 'react';
import HairProperty from './HairProperty';

export default class HairProperties extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const { properties, header } = this.props
		const hairProperties = properties.map( (property)=> <HairProperty hairProperty={property} hairPropType={this.props.hairPropType}/> )
		return (
			<div>
				<div className='header'>
					{ header }
				</div>
				<div className='details'>
					{ hairProperties }
				</div>
			</div>
		);
	}
}
