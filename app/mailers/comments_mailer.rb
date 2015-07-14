class CommentsMailer < ApplicationMailer
  def notify_commentable_owner(comment)
    @commentable = comment.commentable
    # we're assuming all commentable classes are associated with a user
    @owner       = @commentable.user
    mail(to: @owner.email, subject: "You've got a comments")
  end
end
