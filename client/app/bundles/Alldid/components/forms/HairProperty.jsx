import React from 'react';

export default class HairProperty extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
			xhr: null,
			selectedClass: this.props.selected ? 'selected' : null
		}
	}

	handlePropertyChange =(event)=> {
		const target = event.target
		const { hairPropType, hairProperty } = this.props
		this.state.xhr ? this.state.xhr.abort() : null;
		this.state.xhr = $.ajax({
			url: `/change_hair_properties`,
			method: 'PUT',
			dataType: 'json',
			data: {
				"hair_property_id": hairProperty.id,
				"prop_type": hairPropType
			},
			success: (data) => {
				$(`.${hairPropType}.selected`).removeClass('selected')
				$(target).addClass('selected')
			}
		});
	}

	render () {
		const { name, description } = this.props.hairProperty

		return (
			<div className={`item ${this.state.selectedClass} ${this.props.hairPropType}`} onClick={this.handlePropertyChange}>
				<div className="name">
					{ name }
				</div>
				<div className="overlay">
					<div className="description">
						{ description }
					</div>
				</div>
			</div>
		);
	}
}
