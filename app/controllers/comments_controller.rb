class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket

  def create
    @comment = @ticket.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @ticket, notice: "Comment was successfully created."
    else
      redirect_to @ticket, alert: "Failed to create comment."
    end
  end

  def destroy
    @comment = @ticket.comments.find(params[:id])
    @comment.destroy
    redirect_to @ticket, notice: "Comment was successfully deleted."
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
