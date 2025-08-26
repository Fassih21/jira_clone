class History < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  validates :from_status, presence: true
  validates :to_status, presence: true
  validates :user_id, presence: true
  validates :ticket_id, presence: true
end
