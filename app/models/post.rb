class Post < ApplicationRecord
  # validates_presence_of :title
  validates :title, :content, presence: true
  has_many :comments, dependent: :destroy
end
