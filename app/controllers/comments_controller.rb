class CommentsController < ApplicationController
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @ticket, notice: "Comment was successfully created."
    else
      redirect_to @ticket, alert: "Failed to create comment."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.ticket, notice: "Comment was successfully deleted."
  end
end

private

def comment_params
  params.require(:comment).permit(:title, :body)
end
