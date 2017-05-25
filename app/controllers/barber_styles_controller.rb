class BarberStylesController < ApplicationController
	skip_before_action :verify_authenticity_token

	def create
		@barber_style = BarberStyle.new(barber_style_params)

		respond_to do |format|
			if @barber_style.save
				format.json { render json: @barber_style }
			else
				format.json { render json: @barber_style.errors, status: :unprocessable_entity }
			end
		end
	end

	def delete_barber_style
		@barber_style = BarberStyle.where({barber_id: params[:barber_id], style_id: params[:style_id]})

		respond_to do |format|
			if @barber_style.delete_all
				format.json { render json: @barber_style }
			else
				format.json { render json: @barber_style.errors, status: :unprocessable_entity }
			end
		end
	end

	def barber_style_params
		params.require(:barber_style).permit(:barber_id, :style_id)
	end

end
