class HistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket

  def index
    @histories = @ticket.histories.order(created_at: :desc)
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end
