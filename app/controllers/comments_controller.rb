class CommentsController < ApplicationController

  after_filter :verify_authorized

  def create

    @comment = Comment.new(comment_params)

    @comment.creator_id = current_user.id

    authorize @comment, :create?

    if @comment.save
      render @comment
    else

      render ""
    end

  end

  def destroy

    @comment = Comment.find(params[:id])

    authorize @comment, :destroy?

    @comment.destroy


    render json: {status: 200}


  end

  private

  def comment_params
    params.require(:comment).permit(:content, :entity_type, :entity_id)

  end
end
