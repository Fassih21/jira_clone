class Ticket < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  belongs_to :dev, class_name: "User", foreign_key: :dev_id, optional: true
  belongs_to :qa, class_name: "User", foreign_key: :qa_id, optional: true

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: %w[open in_progress closed] }
end
