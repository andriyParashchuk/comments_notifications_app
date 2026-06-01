class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path, status: :see_other }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @comment = current_user.comments.find(params[:id])

    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to root_path, status: :see_other }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy

    redirect_to root_path, notice: I18n.t("comments.deleted")
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
