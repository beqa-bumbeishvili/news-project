class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :news, foreign_key: true
      t.string :comment
    end
  end
end
