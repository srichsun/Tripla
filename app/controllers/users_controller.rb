class UsersController < ApplicationController
  before_action :find_the_user, only: [:follow, :unfollow]
  before_action :find_current_user, only: [:follow, :unfollow, :clock_in]

  def clock_in
    kind = params[:kind]

    if Routine::TYPES.include?(kind)
      @current_user.clock_in(kind)

      render json: @current_user.routines.order('created_at DESC') and return
    else
      render json: { error: "wrong type, type can only be #{Routine::TYPES}" }, status: :bad_request and return
    end
  end

  def follow
    @current_user.follow(@user)

    render json: @current_user.following and return
  end

  def unfollow
    @current_user.unfollow(@user)

    render json: @current_user.following and return
  end

  private

  def find_the_user
    @user = User.find(params[:user_id])
  end

  def find_current_user
    @current_user = User.find(params[:current_user_id])
  end
end
