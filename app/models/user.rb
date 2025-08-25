class User < ApplicationRecord
  has_many :created_tickets, class_name: "Ticket", foreign_key: "creator_id", dependent: :nullify
  has_many :assigned_tickets_as_dev, class_name: "Ticket", foreign_key: "dev_id", dependent: :nullify
  has_many :assigned_tickets_as_qa, class_name: "Ticket", foreign_key: "qa_id", dependent: :nullify

  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: "admin", dev: "dev", qa: "qa", user: "user" }

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: roles.keys }
end
