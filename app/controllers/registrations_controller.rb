class RegistrationsController < Devise::RegistrationsController
  layout 'devise'

  def new

    @organisation = Organisation.new()
    super
  end


end
