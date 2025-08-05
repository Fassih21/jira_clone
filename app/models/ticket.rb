class Ticket < ApplicationRecord
<<<<<<< HEAD
  belongs_to :user
  belongs_to :dev
  belongs_to :qa
=======
  belongs_to :user 
 
  belongs_to :dev, class_name: 'User', foreign_key: 'dev_id'
  belongs_to :qa,  class_name: 'User', foreign_key: 'qa_id'
>>>>>>> migrations-and-model
end
