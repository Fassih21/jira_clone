class User < ApplicationRecord
 validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: %w[admin user] }
   enum role: { qa: 2, dev: 1, admin: 1, user: 3 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
