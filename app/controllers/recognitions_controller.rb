class RecognitionsController < ApplicationController

	after_filter :verify_authorized, :except => :index
  after_filter :verify_policy_scoped, :only => :index

  def index
    @recognitions = policy_scope(Recognition).page params[:page]
  end

  def new
  	@recognition = Recognition.new()
  	@users = policy_scope(User)

  	authorize @recognition, :new?
  end


  def create
  	@recognition = Recognition.new(recognition_params)
    @recognition.creator = current_user
    @recognition.organisation = current_user.organisation

    @users = policy_scope(User)

    authorize @recognition, :create?

    if @recognition.save
      flash[:success] = "Recognition submitted successfully."
      redirect_to recognitions_path
    else
      flash.now[:danger] = "Unable to submit recognition."
      render 'new'
    end

  end

  private

  def recognition_params
    params.require(:recognition).permit(:content, :recognised_id, :points)
  end
end
