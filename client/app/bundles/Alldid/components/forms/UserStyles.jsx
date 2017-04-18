import React from 'react';
import StyleTag from './StyleTag';
import _ from 'underscore';

export default class UserStyles extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		const styles = this.props.styles.map( function(style) {
			return <StyleTag name={style.name} key={style.id} title=''/>
		});
		return (
			<div className='user-styles'>
				{styles}
			</div>
		);
	}
}
