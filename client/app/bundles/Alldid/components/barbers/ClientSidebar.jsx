import React from 'react';

export default class ClientSidebar extends React.Component {
	constructor(props) {
		super(props)
	}

	render () {
		return (
			<div id='client-sidebar-container' className='col-md-3'>
				<div className='user-avatar'/>
			</div>
		);
	}
}
