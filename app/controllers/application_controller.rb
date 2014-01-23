class ApplicationController < ActionController::Base

  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_menu_item

  before_filter :authenticate_user!

  def after_sign_in_path_for(resource)
    pages_path
  end

  private
  def set_menu_item

    case controller_name
    when "pages"
      @active_menu = "pages"
    when "ideas"
      @active_menu = "ideas"
    else
      @active_menu = ""
    end


  end

end
