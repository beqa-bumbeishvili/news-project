class CreateNewsVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :news_versions do |t|
      t.references :news, foreign_key: true
      t.string :title
      t.string :content
      t.datetime :published_at
      t.references :post_type, foreign_key: true
      t.datetiem :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
