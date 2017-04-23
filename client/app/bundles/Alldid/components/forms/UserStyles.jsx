import React from 'react';
import Select from 'react-select';
import StyleTag from './StyleTag';
import _ from 'underscore';

export default class UserStyles extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
			xhr: null,
			user_styles: this.props.user_styles,
			showResultsLink: null
		}
		this.handleStylesChange = this.handleStylesChange.bind(this);
	}

	handleStylesChange(data) {
		const profile_id = this.props.profile_id
		this.state.xhr ? this.state.xhr.abort() : null;
		this.state.xhr = $.ajax({
			url: `/profile/${profile_id}`,
			method: 'PUT',
			success: (newData) => {
				this.setState({ user_styles: newData }, function(){
					this.setState({ showResultsLink: (this.state.xhr !== null || this.state.xhr.readyState === 4)})
				});
			}
		});
	}

	render () {
		// const styles = this.props.all_styles.map( function(style) {
		// 	return <StyleTag name={style.name} key={style.id} title=''/>
		// });

		const styles = this.props.all_styles.map( function(style) {
			return {value: style, label: (style.charAt(0).toUpperCase() + style.slice(1))}
		});
		return (
			<div className='user-styles'>
				<Select
					name="profile[styles]"
					id="profile_styles"
					multi={true}
					joinValues={true}
					options={styles}
					value={this.state.user_styles[0] === "" ? null : this.state.user_styles}
					onChange={this.handleStylesChange}
				/>
			</div>
		);
	}
}
