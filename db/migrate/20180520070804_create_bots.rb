class CreateBots < ActiveRecord::Migration[5.2]
  def change
    create_table :bots do |t|
      t.references :user, index: true
      t.references :parent, index: true
      t.string :message, null: false
      t.text :response
      t.text :prepend
      t.text :append
      t.boolean :published, default: true
      t.timestamps
    end
  end
end
