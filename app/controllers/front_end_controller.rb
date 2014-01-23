class FrontEndController < ApplicationController
  layout 'front_end'

  skip_before_filter :authenticate_user!

  def index

  end
end
