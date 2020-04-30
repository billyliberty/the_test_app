class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :index]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success]="Welcome!"
        redirect_to @user
      else
    render 'new'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by(params[:id])
    if @user.update(user_params)
      #Update successful
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in to continue"
        redirect_to login_path
      end
    end

    # def correct_user
    #  @user = User.find(params[:id])
    #  redirect_to root_path unless current_users?(@user)
    # end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
