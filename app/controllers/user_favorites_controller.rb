class UserFavoritesController < ApplicationController
	def create
		@favorite = UserFavorite.new(params[:favorite])
		
		respond_to do |format|
			if @favorite.save
				format.json { render json: @favorite }
			else
				format.json { render json: @favorite.errors, status: :unprocessable_entity }
			end
		end
	end

	def favorite_params
		params.require(:user_favorite).permit(:user_id, :profile_id)
	end

end
