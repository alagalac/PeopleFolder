class FeedbacksController < ApplicationController

  after_filter :verify_authorized
  after_filter :verify_policy_scoped, :only => :index

  def index
    @feedbacks = policy_scope(Feedback).page params[:page]
    authorize @feedbacks, :index?
  end

  def new
    @feedback = Feedback.new()

    authorize @feedback, :new?
  end

  def create
    @feedback = Feedback.new(feedback_params)

    if not params[:anonymous]
      @feedback.creator = current_user
    end

    @feedback.organisation = current_user.organisation

    authorize @feedback, :create?

    if @feedback.save
      flash[:success] = "Feedback submitted successfully."
      redirect_to new_feedback_path
    else
      flash.now[:danger] = "Unable to submit feedback."
      render 'new'
    end
  end

  def destroy
    @feedback = Feedback.find(params[:id])

    authorize @feedback, :destroy?

    @feedback.destroy

    flash[:success] = "Feedback deleted successfully."
    redirect_to feedbacks_path
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content)

  end

end
