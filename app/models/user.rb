class User < ApplicationRecord
  include Clearance::User
  has_many :locations, dependent: :destroy
  has_many :settings, dependent: :destroy
end
