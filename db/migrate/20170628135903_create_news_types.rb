class CreateNewsTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :news_types do |t|
      t.string :name
      t.string :id_name
    end
    NewsType.create(name: 'დრაფტი', id_name: 'draft')
    NewsType.create(name: 'აქტიური', id_name: 'active')
    NewsType.create(name: 'წაშლილი', id_name: 'deleted')
  end
end
