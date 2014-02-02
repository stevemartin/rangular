class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :description
      t.references :author, index: true

      t.timestamps
    end
  end
end
