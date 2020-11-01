class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :lastname
      t.string :firstname
      t.string :website
      t.text :intro
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
