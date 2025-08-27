class Ticket < ApplicationRecord
  STATUSES = [ "open", "in_progress", "closed" ]

  belongs_to :dev, class_name: "User", foreign_key: "dev_id", optional: true
  belongs_to :qa, class_name: "User", foreign_key: "qa_id", optional: true
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
end
