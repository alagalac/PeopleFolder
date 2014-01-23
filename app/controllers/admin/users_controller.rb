class Admin::UsersController < ApplicationController

  def index
    @users = User.where(organisation_id: current_user.organisation_id)
  end

  def new
    @user = User.new()
    @user_groups = UserGroup.where(organisation_id: current_user.organisation_id)
  end

  def create
    @user = User.new(user_params)
    @user_groups = UserGroup.where(organisation_id: current_user.organisation_id)


    @user.organisation = current_user.organisation

    if @user.save
      flash.now[:success] = "User created successfully."
      redirect_to admin_users_path
    else
      flash.now[:danger] = "Unable to create user."
      
      render 'new'
    end
  end

  def edit
    
    @user = User.where(organisation_id: current_user.organisation_id, id: params[:id]).first
    @user_groups = UserGroup.where(organisation_id: current_user.organisation_id)

  end

  def update

    @user = User.where(organisation_id: current_user.organisation_id, id: params[:id]).first
    @user_groups = UserGroup.where(organisation_id: current_user.organisation_id)

    if @user.update_attributes(user_params)
      flash[:success] = "User updated"
      redirect_to admin_users_path
    else
      flash.now[:danger] = "Unable to update user."
      render 'edit'
    end

    def destroy

      @user = User.find(params[:id])
      @user.destroy

      flash[:success] = "User deleted successfully."
      redirect_to admin_users_path
    end
    

  end


  private

  def user_params
    #if password is blank, update nothing
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :user_group_id)

  end
end
