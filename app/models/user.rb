class User < ApplicationRecord
  has_many :created_tickets, class_name: "Ticket", foreign_key: "user_id"
  has_many :assigned_developer_tickets, class_name: "Ticket", foreign_key: "dev_id"
  has_many :assigned_qa_tickets, class_name: "Ticket", foreign_key: "qa_id"


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  enum role: { admin: 1, dev: 2, qa: 3, user: 4 }


  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: roles.keys }
end
