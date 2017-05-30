import React from 'react';

export default class StyleTag extends React.Component {
	constructor(props) {
		super(props)

		var endorsedClass = this.props.barberStyle.endorsed ? 'endorsed' : 'not-endorsed'

		this.state = {
			endorsements: this.props.barberStyle.endorsements,
			endorsedClass: endorsedClass,
			endorsed: this.props.barberStyle.endorsed,
			xhr: null
		}
	}

	handleEndorseClick = (event) => {
		const { id, clientId } = this.props.barberStyle

		if (this.state.endorsed) {
			this.state.xhr = $.ajax({
				url: `/delete_endorsement`,
				method: 'POST',
				data: {
					"barber_style_id": id,
					"client_id": clientId,
				},
				dataType: 'json',
				success: () => { this.toggleEndorsed() }
			});
		} else {
			this.state.xhr = $.ajax({
				url: `/endorsements`,
				method: 'POST',
				data: {
					"endorsement": {
						"barber_style_id": id,
						"client_id": clientId
					}
				},
				dataType: 'json',
				success: () => { this.toggleEndorsed() }
			});
		}
	}

	toggleEndorsed =()=> {
		this.toggleEndorsedWithCallback( () => {
			var endorsedClass = this.state.endorsed ? 'endorsed' : 'not-endorsed'

			if (this.props.barberStyle.endorsed) {
				var endorsements = this.state.endorsed ? this.props.endorsements : this.props.endorsements - 1
			} else {
				var endorsements = this.state.endorsed ? this.props.endorsements + 1 : this.props.endorsements
			}

			this.setState({ endorsedClass: endorsedClass, endorsements: endorsements })
		})
	}

	toggleEndorsedWithCallback = (callback) => {
		this.setState({ endorsed: !this.state.endorsed }, ()=> {
			callback();
		})
	}

	capitalize = (string) => {
		return string.charAt(0).toUpperCase() + string.slice(1)
	}

	render () {
		var clickableClass = (this.props.links === undefined) ? 'not-clickable' : null
		return (
			<div className='style-tag light-tag style-endorsement-tag'>
				{this.capitalize(this.props.barberStyle.name)}
				<div className={`endorsement-tag ${clickableClass} ${this.state.endorsedClass}`} onClick={ this.handleEndorseClick }>
					<span className='content' data-endorsements={this.state.endorsements}/>
				</div>
			</div>
		);
	}
}
