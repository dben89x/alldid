class StylesController < ApplicationController
	before_action :set_style, only: [:show, :edit, :update, :destroy]
	authorize_resource

	def new
		@style = Style.new
	end

	def edit
	end

	def index
		@styles = Style.all
	end

	def create
		@style = Style.new(style_params)

		respond_to do |format|
			if @style.save
				flash[:success] = 'Style was successfully created.'
				format.html { redirect_to styles_path }
				format.json { render :show, status: :created, location: @style }
			else
				format.html { render :new }
				format.json { render json: @style.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @style.update(style_params)
				flash[:success] = 'Style was successfully updated.'
				format.html { redirect_to styles_path }
				format.json { render :show, status: :ok, location: @style }
			else
				format.html { render :edit }
				format.json { render json: @style.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
			@style.destroy
		respond_to do |format|
			flash[:success] = 'Style was successfully destroyed.'
			format.html { redirect_to styles_path }
			format.json { head :no_content }
		end
	end

	private
	def set_style
		@style = Style.find(params[:id])
	end

	def style_params
		params.require(:style).permit(:name, :description, :url, :url_cache)
	end

end
