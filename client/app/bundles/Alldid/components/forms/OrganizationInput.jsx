import React from 'react';

export default class OrganizationInput extends React.Component{

	constructor(props) {
		super(props);
		this.state = {
			inputValue: this.props.organization.name,
			xhr: false,
			faClass: null,
			orgName: this.props.orgName
		}
	}

	handleInput =(event)=> {
		this.setState({inputValue: event.target.value, orgName: event.target.value}, ()=>{
			if (!(this.state.orgName)) {
				this.setState({orgName: `your barbershop`})
			}
			this.handleFaChange()

			const { organization } = this.props
			const { inputValue } = this.state

			if(this.state.xhr !== false) {clearTimeout(this.state.xhr)}

			this.state.xhr = setTimeout(() => {
				$.ajax({
					url: `/organizations/${organization.id}`,
					method: 'PUT',
					data: { "organization": {
						"name": inputValue
					}},
					dataType: 'json',
					success: (data) => {
						this.setState({xhr: false})
						this.handleFaChange()
					}
				});
			}, 300)
		})
	}

	handleFaChange =()=> {
		if (this.state.xhr) {
			this.setState({faClass: 'fa-spin fa-spinner'})
		} else {
			this.setState({faClass: 'fa-check'})
		}
	}

	render() {
		const { organization } = this.props

		return (
			<div className="org-input-wrapper col-md-6 col-md-offset-3">
				<h1 className='header'>Edit {this.state.orgName}</h1>
				<input value={this.state.inputValue} className="organization-input" placeholder={`Barbershop Name`} onChange={this.handleInput}/>
				<span className={`fa ${this.state.faClass}`}/>
			</div>
		);
	}
}
