class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title,        null: false
      t.string :tagbody
      t.string :url
      t.text :body,           null: false
      t.integer :status,      null: false, default: 0
      t.integer :category_id, null: false
      t.references :user,     foreign_key: true

      t.timestamps
    end
  end
end
