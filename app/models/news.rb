class News < ApplicationRecord

  has_many :news_versions, dependent: :destroy

  accepts_nested_attributes_for :news_versions, allow_destroy: true

  before_create :set_number

  private

  def set_number
    self.number = News.last.number + 1
  end

end
