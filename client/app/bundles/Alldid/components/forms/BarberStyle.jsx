import React from 'react';
import _ from 'underscore';

export default class BarberStyle extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
			xhr: null,
			selected: this.props.selected
		}
	}

	handleStyleChange = (event) => {
		const target = event.target

		this.setState({selected: !this.state.selected}, ()=>{
			this.state.xhr ? this.state.xhr.abort() : null;

			if (this.state.selected) {
				this.state.xhr = $.ajax({
					url: `/barber_styles`,
					method: 'POST',
					dataType: 'json',
					data: { "barber_style": {
						"barber_id": this.props.userId,
						"style_id": this.props.style.id
					}},
					success: (data) => {
						$(target).addClass('selected')
					}
				});
			} else {
				this.state.xhr = $.ajax({
					url: `/delete_barber_style`,
					method: 'POST',
					dataType: 'json',
					data: {
						"barber_id": this.props.userId,
						"style_id": this.props.style.id
					},
					success: (data) => {
						$(target).removeClass('selected')
					}
				});
			}
		})

	}

	render () {
		const {style} = this.props
		return (
			<div className={`image-container ${this.state.selected ? 'selected' : null}`} onClick={this.handleStyleChange}>
				<img src={`/assets/styles/${style.url}`} width={170} className='style-img'/>
				<div className='overlay'>
					<div className='text'>{style.name.charAt(0).toUpperCase() + style.name.slice(1)}</div>
				</div>
			</div>
		);
	}
}
