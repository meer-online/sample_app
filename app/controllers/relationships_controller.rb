class RelationshipsController < ApplicationController
	before_filter :authenticate

	def create
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		#For ajab based request
		respond_to do | format|
			format.html { redirect_to @user }
			format.js
		end
		#for Non-Ajax request
		#redirect_to @user
	end

	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		#For ajab based request
		respond_to do | format|
			format.html { redirect_to @user }
			format.js
		end
		#for Non-Ajax request
		#redirect_to @user
	end
end