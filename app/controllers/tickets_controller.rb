class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: %i[show edit update destroy mark_done]
  after_action :verify_authorized, except: :index

  def index
    @tickets = policy_scope(Ticket)
    @ticket = Ticket.new
  end

  def show
    authorize @ticket
  end

  def new
    @ticket = Ticket.new
    authorize @ticket
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.creator_id = current_user.id
    authorize @ticket

    if @ticket.save
      redirect_to tickets_path, notice: "Ticket created successfully."
    else
      @tickets = policy_scope(Ticket)
      flash.now[:alert] = @ticket.errors.full_messages.join(", ")
      render :index
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
      redirect_to tickets_path, notice: "Ticket deleted successfully."
    else
      redirect_to ticket_path(@ticket), alert: "Unable to delete Ticket."
    end
  end

  def mark_done
    authorize @ticket, :mark_done?
    if @ticket.update(status: "closed")
      redirect_to tickets_path, notice: "Ticket marked as done."
    else
      redirect_to tickets_path, alert: "Unable to mark ticket as done."
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket)
          .permit(:title, :description, :status, :assigned_developer_id, :assigned_qa_id)
          .tap do |whitelisted|
            whitelisted[:dev_id] = whitelisted.delete(:assigned_developer_id) if whitelisted[:assigned_developer_id]
            whitelisted[:qa_id]  = whitelisted.delete(:assigned_qa_id) if whitelisted[:assigned_qa_id]
          end
  end
end
