class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :dev
  belongs_to :qa
end
