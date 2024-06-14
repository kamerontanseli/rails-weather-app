class Setting < ApplicationRecord
  belongs_to :user
  validates :user, :theme, presence: true
end
