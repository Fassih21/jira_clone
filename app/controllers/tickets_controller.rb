class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: %i[show edit update destroy assign mark_done]
  after_action :verify_authorized, except: :index

  def index
        @tickets=policy_scope(Ticket)
  end

  def show
    authorize @ticket
  end

  def new
    @ticket = Ticket.new
    authorize @ticket
  end

  def create
    @ticket = current_user.created_tickets.build(ticket_params)
    authorize @ticket

    if @ticket.save
      redirect_to @ticket, notice: "Ticket created successfully."
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
      redirect_to @ticket, notice: "Ticket updated successfully."
    else
      render :edit
    end
  end

  def destroy
    authorize @ticket
   if @ticket.destroy
    redirect_to tickets_path,
      notice: "Ticket deleted successfully."
   else
    redirect_to ticket_path(@ticket),
      alert: "Unable to delete Ticket."
   end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :assigned_developer_id, :assigned_qa_id, :status)
  end
end
