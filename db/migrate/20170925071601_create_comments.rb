class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :author
      t.text :content
      t.text :post_id

      t.timestamps
    end
  end
end
