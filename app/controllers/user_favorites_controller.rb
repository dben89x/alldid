class UserFavoritesController < ApplicationController
	def create
		respond_to do |format|
			if favorite = UserFavorite.create(favorite_params)
				format.json
			else
				format.json { render json: favorite.errors, status: :unprocessable_entity }
			end
		end
	end

	def favorite_params
		params.require(:user_favorite).permit(:user_id, :profile_id)
	end

end
