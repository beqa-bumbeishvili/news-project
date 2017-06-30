class NewsVersion < ApplicationRecord
  has_attached_file :image, styles: { large: '600x600', medium: '300x300', thumb: '100x100' }, default_url: 'https://ichef.bbci.co.uk/news/1024/media/images/48351000/gif/_48351569_640x360-news.gif'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

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
