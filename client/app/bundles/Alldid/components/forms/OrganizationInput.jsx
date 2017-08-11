import React from 'react';

export default class OrganizationInput extends React.Component{

	constructor(props) {
		super(props);
		this.state = {
			nameValue: this.props.organization.name,
			phoneValue: this.props.organization.phone,
			xhr: false,
			faClass: null,
			orgName: this.props.orgName,
			orgPhone: this.props.orgPhone
		}
	}

	handleInput =(event, input)=> {
		this.setState({[input]: event.target.value, orgName: event.target.value}, ()=>{
			this.setState({orgName: this.state.nameValue}, ()=>{
				if (!(this.state.orgName)) {
					this.setState({orgName: `your barbershop`})
				}
			})
			this.handleFaChange()

			const { organization } = this.props
			const { nameValue, phoneValue } = this.state

			if(this.state.xhr !== false) {clearTimeout(this.state.xhr)}

			this.state.xhr = setTimeout(() => {
				$.ajax({
					url: `/organizations/${organization.id}`,
					method: 'PUT',
					data: { "organization": {
						"name": nameValue,
						"phone": phoneValue
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
				<h1 className='header'>
					Edit {this.state.orgName}
					<span className={`fa ${this.state.faClass}`}/>
				</h1>

				<input value={this.state.nameValue} className="organization-input" placeholder={`Barbershop Name`} onChange={(e)=> {this.handleInput(e, "nameValue")}}/>
				<input value={this.state.phoneValue} className="organization-input" placeholder={`Phone Number`} onChange={(e)=> {this.handleInput(e, "phoneValue")}}/>
			</div>
		);
	}
}
