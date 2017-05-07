class EndorsementsController < ApplicationController

	def create
		unless Endorsement.where({client_id: params[:endorsement][:client_id], barber_style_id: params[:endorsement][:barber_style_id]}).any?
			@endorsement = Endorsement.new(endorsement_params)

			respond_to do |format|
				if @endorsement.save
					format.json { render json: @endorsement }
				else
					puts 'foobaz'
					format.json { render json: @endorsement.errors, status: :unprocessable_entity }
				end
			end
		else
			render json: { error: "Endorsement already exists", status: :unprocessable_entity }
		end
	end

	def delete_endorsement
		@endorsements = Endorsement.where({client_id: params[:client_id], barber_style_id: params[:barber_style_id]})

		respond_to do |format|
			if @endorsements.delete_all
				format.json { render json: @endorsements }
			else
				format.json { render json: @endorsements.errors, status: :unprocessable_entity }
			end
		end
	end

	def endorsement_params
		params.require(:endorsement).permit(:barber_style_id, :client_id)
	end

end
