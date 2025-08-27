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
    old_status = @ticket.status

    if @ticket.update(ticket_params)
      if old_status != @ticket.status
        # save history if status changed
        History.create(
          from_status: old_status,
          to_status: @ticket.status,
          user_id: current_user.id,
          ticket_id: @ticket.id
        )
      end
      redirect_to tickets_path, notice: "Ticket updated successfully."
    else
      flash.now[:alert] = @ticket.errors.full_messages.join(", ")
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
    authorize @ticket
    old_status = @ticket.status

    new_status =
      if current_user.admin?
        "closed"
      elsif current_user.role == "dev"
        "in_progress"
      elsif current_user.role == "qa"
        "closed"
      else
        @ticket.status
      end

    if @ticket.update(status: new_status)
      # save history
      History.create(
        from_status: old_status,
        to_status: new_status,
        user_id: current_user.id,
        ticket_id: @ticket.id
      )
      redirect_to tickets_path, notice: "Ticket updated to #{new_status.humanize}."
    else
      redirect_to ticket_path(@ticket), alert: "Unable to update ticket status."
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :status, :dev_id, :qa_id)
  end
end
