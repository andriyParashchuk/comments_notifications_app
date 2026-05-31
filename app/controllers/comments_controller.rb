class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)

    @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
