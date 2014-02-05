class QuestionsController < ApplicationController

  after_filter :verify_authorized, :except => :index
  after_filter :verify_policy_scoped, :only => :index

  def index
    @questions = policy_scope(Question).order(votes_count: :desc).page params[:page]
  end

  def show
    @question = Question.find(params[:id])
    authorize @question, :show?
  end

  def new
    @question = Question.new()
    authorize @question, :new?
  end

  def create
    @question = Question.new(question_params)
    @question.creator = current_user
    @question.organisation = current_user.organisation

    authorize @question, :create?

    if @question.save
      flash[:success] = "Question submitted successfully."
      redirect_to question_path(@question)
    else
      flash.now[:danger] = "Unable to submit question."
      render 'new'
    end
  end

  def destroy

    @question = Question.find(params[:id])
    authorize @question, :destroy?

    @question.destroy

    flash[:success] = "Question deleted successfully."
    redirect_to questions_path

  end

  def edit
    @question = Question.find(params[:id])
    authorize @question, :edit?
  end

  def update
    @question = Question.find(params[:id])
    authorize @question, :update?

    if @question.update_attributes(question_params)
      flash[:success] = "Question updated."
      redirect_to question_path(@question)
    else
      flash.now[:danger] = "Unable to update question."
      render 'edit'
    end
  end

  def vote
    @question = Question.find(params[:id])

    @vote = @question.votes.where(creator: current_user).take

    authorize @question, :vote?

    if @vote.blank?
      @vote = @question.votes.build()
      @vote.creator = current_user
      if @vote.save()
        respond_to do |format|
          format.json { render json: @question.votes.count }
        end
      else
        respond_to do |format|
          format.json { render json: {status: 500} } # error
        end
      end
    else
      @vote.destroy
      respond_to do |format|
        format.json { render json: @question.votes.count }
      end
    end
  end

  private

  def question_params
    params.require(:question).permit(:content, :title)
  end
end
