class NewsVersion < ApplicationRecord
  belongs_to :news
  belongs_to :news_type

  before_create :set_dates
  before_update :set_updated_at


  private

  def set_dates
    self.created_at = DateTime.now
    self.updated_at = DateTime.now
  end

  def set_updated_at
    self.updated_at = DateTime.now
  end


end
