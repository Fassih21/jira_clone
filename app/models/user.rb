class User < ApplicationRecord

  has_many :tickets, class_name: 'Ticket', foreign_key: 'user_id'
  has_many :dev_tickets, class_name: 'Ticket', foreign_key: 'dev_id'
  has_many :qa_tickets, class_name: 'Ticket', foreign_key: 'qa_id'
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
