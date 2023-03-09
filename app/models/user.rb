class User < ApplicationRecord
  has_many :sleep_sessions

  validates :name, presence: true
end
