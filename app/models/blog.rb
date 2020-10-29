class Blog < ApplicationRecord
 has_many :comments, dependent: :destroy

 validates :title, presence: true, length: { minimum: 3, maximum: 30}

 validates :content, presence: true

def self.keyword_search (keyword)
    keyword_list = keyword.split((/\s+/)).map{ |keyword| "%#{keyword}%" }
    query = (["title like ?"] * keyword_list.size).join(" and ")
    where(query, *keyword_list)
end

scope :data_from_narrow_down, ->(from) { where('created_at >= ?', from) }
scope :data_to_narrow_down, ->(to) { where('created_at <= ?', to) }
scope :data_from_to_narrow_down, ->(from, to) { where(created_at: from..to) }

def self.data_narrow_down(from, to)
  return data_from_to_narrow_down(from, to) if from.present? && to.present?
  return data_from_narrow_down(from) if from.present?
  return data_to_narrow_down(to)
end

 def self.search_blogs(keyword, from, to)
    if keyword.present?
      return keyword_search(keyword).data_from_to_narrow_down(from, to) if from.present? && to.present?
      return keyword_search(keyword).data_from_narrow_down(from) if from.present?
      return keyword_search(keyword).data_to_narrow_down(to) if to.present?
      return keyword_search(keyword)
    else
      return data_from_to_narrow_down(from, to) if from.present? && to.present?
      return data_from_narrow_down(from) if from.present?
      return data_to_narrow_down(to) if to.present?
    end
 end

end
