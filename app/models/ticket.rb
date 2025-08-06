class Ticket < ApplicationRecord
  belongs_to :user 
  
 
  belongs_to :dev, class_name: 'User', foreign_key: 'dev_id'
  belongs_to :qa,  class_name: 'User', foreign_key: 'qa_id'
  has_many :comments, dependent: :destroy
end
