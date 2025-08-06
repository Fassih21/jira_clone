class CommentsController < ApplicationController
  def create
  @ticket = Ticket.find(params[:ticket_id])
  @comment = @ticket.comments.build(comment_params)
  @comment.user = current_user

  authorize @comment

  if @comment.save
    redirect_to @ticket, notice: 'Comment was successfully created.'
  else
    render 'tickets/show', alert: 'Failed to create comment.'
  end
end

private

def comment_params
  params.require(:comment).permit(:title, :body)
end

end
