class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket

  def create
    authorize @ticket, :show? # Ensure the user has permission to view the ticket
    @comment = @ticket.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @ticket, notice: "Comment was successfully created."
    else
      redirect_to @ticket, alert: "Failed to create comment."
    end
  end

  def destroy
    authorize @ticket, :show? # Ensure the user has permission to view the ticket
    @comment = @ticket.comments.find(params[:id])
    authorize @comment, :destroy? # Ensure the user has permission to destroy the comment
    @comment.destroy
    redirect_to @ticket, notice: "Comment was successfully deleted."
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end
