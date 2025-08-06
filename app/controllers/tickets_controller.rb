class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = policy_scope(Ticket).where("user_id = ? OR dev_id = ? OR qa_id = ?", current_user.id, current_user.id, current_user.id)
  end

  def show
    authorize @ticket
  end

  def new
    @ticket = current_user.tickets.build
    authorize @ticket
  end

  def create
    @ticket = current_user.tickets.build(ticket_params)
    authorize @ticket
    if @ticket.save
      redirect_to @ticket, notice: 'Ticket was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @ticket
  end

  def update
    authorize @ticket
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: 'Ticket was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @ticket
    @ticket.destroy
    redirect_to tickets_path, notice: 'Ticket was successfully deleted.'
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :status, :dev_id, :qa_id)
  end
end
