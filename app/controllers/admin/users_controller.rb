class Admin::UsersController < ApplicationController

  after_filter :verify_authorized
  after_filter :verify_policy_scoped, :only => :index

  def index
    @users = policy_scope(User).page params[:page]
    authorize @users, :index?
  end

  def new
    @user = User.new()
    @user_groups = UserGroup.where(organisation_id: current_user.organisation_id)
    authorize @user, :new?
  end

  def create
    @user = User.new(user_params)
    @user_groups = UserGroup.where(organisation_id: current_user.organisation_id)


    @user.organisation = current_user.organisation

    authorize @user, :create?

    if @user.save
      flash.now[:success] = "User created successfully."
      redirect_to admin_users_path
    else
      flash.now[:danger] = "Unable to create user."
      
      render 'new'
    end
  end

  def edit
    
    @user = User.find(params[:id])
    @user_groups = UserGroup.where(organisation_id: current_user.organisation_id)

    authorize @user, :edit?

  end

  def update

    @user = User.find(params[:id])
    @user_groups = UserGroup.where(organisation_id: current_user.organisation_id)

    authorize @user, :update?

    if @user.update_attributes(user_params)
      flash[:success] = "User updated"
      redirect_to admin_users_path
    else
      flash.now[:danger] = "Unable to update user."
      render 'edit'
    end
  end

  def destroy

    @user = User.find(params[:id])

    authorize @user, :destroy?

    @user.destroy

    flash[:success] = "User deleted successfully."
    redirect_to admin_users_path
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
