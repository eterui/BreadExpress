class UsersController < ApplicationController
  include BreadExpressHelpers::Cart
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @users = User.alphabetical.paginate(:page => params[:page]).per_page(10)
    @active_employees = User.alphabetical.employees.active.paginate(:page => params[:page]).per_page(10)
    @inactive_employees = User.alphabetical.employees.inactive.paginate(:page => params[:page]).per_page(10)
  end

  def show

  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "Thank you for signing up!"
    else
      flash[:error] = "This user could not be created."
      render "new"
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "#{@user.username} is updated."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "Successfully removed #{@user.username} from Bread Express."
    redirect_to users_url
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      if current_user
        params.require(:user).permit(:username, :password, :password_confirmation, :role, :active) 
      end 
    end
end
