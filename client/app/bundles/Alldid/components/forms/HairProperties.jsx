import React from 'react';
import HairProperty from './HairProperty';

export default class HairProperties extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const { properties, header } = this.props
		const hairProperties = properties.map( (property)=> {
			var selected = property.id === this.props.currentId
			console.log(property.id)
			console.log(this.props.currentId)
			return <HairProperty key={property.id} hairProperty={property} hairPropType={this.props.hairPropType} selected={selected}/>
		})
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
