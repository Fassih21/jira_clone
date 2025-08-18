class User < ApplicationRecord
       has_many :created_tickets, class_name: "Ticket", foreign_key: "creator_id"
       has_many :assigned_developer_tickets, class_name: "Ticket", foreign_key: "developer_id"
       has_many :assigned_qa_tickets, class_name: "Ticket", foreign_key: "qa_id"

       validates :email, presence: true, uniqueness: true
       validates :encrypted_password, presence: true
       validates :name, presence: true
       validates :role, presence: true, inclusion: { in: %w[admin user] }

       enum role: { admin: 1, dev: 2, qa: 3, user: 4 }
       devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
