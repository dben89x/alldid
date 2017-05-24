import React from 'react';
import _ from 'underscore';

export default class BarberStyle extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
			xhr: null,
			selectedClass: this.props.selected ? 'selected' : null
		}
	}

	handleStyleChange = (event) => {
		const target = event.target

		this.state.xhr ? this.state.xhr.abort() : null;
		this.state.xhr = $.ajax({
			url: `/profiles/${this.props.profileId}`,
			method: 'PUT',
			dataType: 'json',
			data: { "profile": {
				"current_style_id": this.props.style.id
			}},
			success: (data) => {
				$('.selected').removeClass('selected')
				$(target).addClass('selected')
			}
		});
	}

	render () {
		const {style} = this.props
		return (
			<div className={`image-container ${this.state.selectedClass}`} onClick={this.handleStyleChange}>
				<img src={`/assets/styles/${style.url}`} width={170} className='style-img'/>
				<div className='overlay'>
					<div className='text'>{style.name.charAt(0).toUpperCase() + style.name.slice(1)}</div>
				</div>
			</div>
		);
	}
}
