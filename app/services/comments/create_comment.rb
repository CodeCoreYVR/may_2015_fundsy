class Comments::CreateComment
  include Virtus.model

  attribute :commentable
  attribute :params, Hash
  attribute :user, User

  attribute :comment, Comment

  def call
    @comment             = user.comments.new params
    @comment.commentable = commentable
    if @comment.save
      CommentsMailer.notify_commentable_owner(@comment).deliver_now
      true
    else
      false
    end
  end

end
