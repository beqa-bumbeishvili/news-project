class AddAttachmentImageToNewsVersions < ActiveRecord::Migration[5.1]
  def self.up
    change_table :news_versions do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :news_versions, :image
  end
end
