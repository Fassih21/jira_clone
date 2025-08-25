class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :dev, foreign_key: :dev_id, class_name: 'User'
  belongs_to :qa, foreign_key: :qa_id, class_name: 'User'

  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true  
  validates :status, presence: true, inclusion: { in: %w[open in_progress closed] } 
end
