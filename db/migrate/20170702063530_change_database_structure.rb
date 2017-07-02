class ChangeDatabaseStructure < ActiveRecord::Migration[5.1]
  def change
    add_column :news, :news_version_id, :integer
    add_foreign_key :news, :news_versions
    add_column :news_versions, :active, :boolean, default: true
    add_column :news_versions, :is_draft, :boolean, default: true
    add_column :news_versions, :mark_for_deletion, :boolean, default: false
    add_index(:news_versions, [:news_id, :active], unique: true, where: 'active = true')
    add_index(:news, [:id, :news_version_id], unique: true)
  end

end

