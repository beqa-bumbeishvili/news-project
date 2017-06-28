class NewsVersion < ApplicationRecord
  belongs_to :news
  belongs_to :post_type
end
