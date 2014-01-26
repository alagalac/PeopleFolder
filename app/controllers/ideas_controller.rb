class IdeasController < ApplicationController

  after_filter :verify_authorized, :except => :index
  after_filter :verify_policy_scoped, :only => :index


  def index
    @ideas = policy_scope(Idea).order(votes_count: :desc)
  end

  def show
    @idea = Idea.find(params[:id])
    authorize @idea, :show?

  end

  def new
    @idea = Idea.new()

    authorize @idea, :new?
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.creator = current_user
    @idea.organisation = current_user.organisation

    authorize @idea, :create?

    if @idea.save
      flash[:success] = "Idea submitted successfully."
      redirect_to idea_path(@idea)
    else
      flash.now[:danger] = "Unable to submit idea."
      render 'new'
    end
  end

  def destroy
    @idea = Idea.find(params[:id])

    authorize @idea, :destroy?

    @idea.destroy

    flash[:success] = "Idea deleted successfully."
    redirect_to ideas_path
  end

  def vote
    @idea = Idea.find(params[:id])

    authorize @idea, :vote?

    @vote = @idea.votes.where(creator: current_user).take

    if @vote.blank?
      @vote = @idea.votes.build()
      @vote.creator = current_user
      if @vote.save()
        respond_to do |format|
          format.json { render json: @idea.votes.count }
        end
      else
        respond_to do |format|
          format.json { render json: {status: 500}} # error
        end
      end
    else
      @vote.destroy
      respond_to do |format|
        format.json { render json: @idea.votes.count }
      end
    end


  end


  private

  def idea_params
    params.require(:idea).permit(:content, :title)

  end
end
