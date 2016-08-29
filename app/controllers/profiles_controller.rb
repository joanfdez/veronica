class ProfilesController < ApplicationController

  before_action :find_user, only: [:show]

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :description, :gender, :student_id, :date_of_birth, :music_habits, :speaking_habits, :year_of_study, :uni_course, :smoking)
  end
end