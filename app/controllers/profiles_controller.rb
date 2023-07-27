class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def show
  end

  def edit
    @goal = @user.goals.first_or_initialize
  end

  def update
    @user.assign_attributes(user_params.except(:target_weight))
    
    if @user.valid?
      @goal = @user.goals.first_or_initialize
      @goal.target_weight = user_params[:target_weight]
  
      if @user.save && @goal.save
        redirect_to profile_path, notice: 'Profile was successfully updated.'
      else
        render :edit
      end
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :age, :height, :weight, :age_public, :height_public, 
      :weight_public, :name, :email, :avatar, :profile, 
      :current_weight, :gender, :target_weight
    )
  end
end
