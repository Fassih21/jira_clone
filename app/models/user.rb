class User < ApplicationRecord
 validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: %w[admin user] }
   enum role: { admin: 1, dev: 2, qa: 3, user: 4 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
