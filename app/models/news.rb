class News < ApplicationRecord
  before_create :set_number

  private

  def set_number
    self.number = News.last.number + 1
  end

end
