class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable

  def create
    service = Comments::CreateComment.new(commentable: @commentable,
                                          params: comment_params,
                                          user: current_user)
    if service.call
      redirect_to @commentable, notice: "Comment Created"
    else
      @comment = service.comment
      render "/#{@commentable.class.name.underscore.pluralize}/show"
    end
    # @comment = current_user.comments.new comment_params
    # @comment.commentable = @commentable
    # if @comment.save
    #   redirect_to @commentable, notice: "Comment Created"
    # else
    #   render "/#{@commentable.class.name.underscore.pluralize}/show"
    # end
  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    if params[:campaign_id]
      @commentable = Campaign.find(params[:campaign_id])
      @campaign    = @commentable.decorate
    elsif params[:discussion_id]
      @commentable = Discussion.find params[:discussion_id]
      @discussion  = @commentable
    end
  end
end
