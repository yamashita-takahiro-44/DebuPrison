class BadgesController < ApplicationController
  def index
    @badges = Badge.all
  end

  def show
    @badge = Badge.find(params[:id])
    @users = @badge.users # このバッジを取得したユーザーの一覧
  end
end
