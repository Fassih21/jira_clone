class History < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  validates :action, presence: true, inclusion: { in: %w[created updated deleted] }
  validates :changes, presence: true
  validates :timestamp, presence: true
  validates :user_id, presence: true
  validates :ticket_id, presence: true
end
