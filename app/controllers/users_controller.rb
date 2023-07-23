class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show] # Deviseのメソッドで、ログインしていないユーザーをログインページにリダイレクトします。

  def index
    @users = User.all
  end

  def show
  end

  def edit
    # ログイン中のユーザーのみが自分の情報を編集できるようにする。
    unless current_user == @user
      redirect_to user_path(@user), alert: "You can't edit someone else's profile."
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully deleted.'
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストとしてログインしました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # 許可されたパラメータのみを通す
    params.require(:user).permit(:name, :email, :avatar, :profile, :current_weight)
  end
end
