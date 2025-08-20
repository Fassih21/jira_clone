class Ticket < ApplicationRecord
  STATUSES = [ "open", "in_progress", "closed" ]

  belongs_to :dev, class_name: "User", foreign_key: "assigned_developer_id", optional: true
  belongs_to :qa, class_name: "User", foreign_key: "assigned_qa_id", optional: true
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :dev_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
end
