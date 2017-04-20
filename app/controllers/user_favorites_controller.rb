class UserFavoritesController < ApplicationController
	include ApplicationHelper

	def index
		@favorites = get_react_barber_objects(current_user.favorites)
		# @barbers = @favorites.collect {|fav| fav.user}
		@profile_id = current_user.profile.id
	end

	def create
		@favorite = UserFavorite.new(favorite_params)

		respond_to do |format|
			if @favorite.save
				format.json { render json: @favorite }
			else
				format.json { render json: @favorite.errors, status: :unprocessable_entity }
			end
		end
	end

	def delete_favorite
		@favorites = UserFavorite.where({user_id: params[:user_id], profile_id: params[:profile_id]})

		respond_to do |format|
			if @favorites.delete_all
				format.json { render json: @favorites }
			else
				format.json { render json: @favorites.errors, status: :unprocessable_entity }
			end
		end
	end

	def favorite_params
		params.require(:favorite).permit(:user_id, :profile_id)
	end

end
