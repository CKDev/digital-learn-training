class Organization < ApplicationRecord
  validates :title, presence: true
end
