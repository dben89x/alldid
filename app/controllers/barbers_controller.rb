class BarbersController < ApplicationController
	def show
		@barber = Barber.find(params[:id])
	end
end
