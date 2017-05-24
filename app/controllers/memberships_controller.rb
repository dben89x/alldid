class MembershipsController < ApplicationController
	before_action :set_membership, only: [:show, :edit, :update, :destroy]
	load_and_authorize_resource
	skip_before_action :verify_authenticity_token

	def destroy
		@membership.destroy
		respond_to do |format|
			format.html { redirect_to '/dashboard', notice: 'Membership was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	def set_membership
		@membership = Membership.find(params[:id])
	end

end
