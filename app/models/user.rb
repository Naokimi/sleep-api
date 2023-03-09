class User < ApplicationRecord
  has_many :sleep_sessions, dependent: :destroy

  validates :name, presence: true
end
