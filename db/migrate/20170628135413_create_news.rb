class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news do |t|
      t.integer :number
      t.datetime :created_at
    end
  end
end
