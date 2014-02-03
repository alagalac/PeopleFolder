class RegistrationsController < Devise::RegistrationsController
  layout 'application', only: [:edit, :update]

  def new
    @organisation = Organisation.new()
    super
    
  end

  def create
    #create user, organisation, and user group. Overriding devise.

    # Build user
    #build_resource
    @user = User.new(user_params)

    # Build organisation
    @organisation = Organisation.create(:name => params[:organisation][:name])

    # Build user groups
    @admin_user_group = UserGroup.create(:name => @organisation.name + " Admin", :group_type => "admin", :organisation => @organisation)
    @normal_user_group = UserGroup.create(:name => @organisation.name + " User", :group_type => "user", :organisation => @organisation)


    @user.organisation = @organisation
    @user.user_group = @admin_user_group


    if @user.save
      if @user.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, @user)
        respond_with @user, :location => after_sign_up_path_for(@user)
      else
        set_flash_message :notice, :"signed_up_but_#{@user.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with @user, :location => after_inactive_sign_up_path_for(@user)
      end
    else
      flash.now[:error] = "Registration unsuccessful."
      clean_up_passwords @user
      respond_with @user
    end
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end


end
