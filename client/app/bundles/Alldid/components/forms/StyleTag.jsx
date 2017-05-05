import React from 'react';

export default class StyleTag extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		var styles = {

		}
		return (
			<div className='style-tag light-tag style-endorsement-tag'>
				{this.props.name}
				<div className='endorsement-tag'>
					<span className='content' data-endorsements='5'/>
				</div>
			</div>
		);
	}
}
