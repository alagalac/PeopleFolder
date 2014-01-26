class RegistrationsController < Devise::RegistrationsController
  layout 'devise'

  def new

    @organisation = Organisation.new()
    super
  end

  def create
    #create user, organisation, and user group. Overriding devise.

    # Build user
    #build_resource
    @user = User.new(params[:user])

    # Build organisation
    @organisation = Organisation.create(params[:organisation])

    # Build user groups
    @admin_user_group = Usergroup.create(:name => @organisation.name + " Admin", :group_type => "admin")
    @normal_user_group = Usergroup.create(:name => @organisation.name + " Admin", :group_type => "user")


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


end
