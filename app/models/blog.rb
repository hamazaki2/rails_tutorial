class Blog < ApplicationRecord
 has_many :comments, dependent: :destroy

 validates :title, presence: true, length: { minimum: 3, maximum: 30}

 validates :content, presence: true
end
