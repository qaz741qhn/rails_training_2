class Diary < ApplicationRecord
  belongs_to :user

  validates :title, :article, :date, presence: true

end