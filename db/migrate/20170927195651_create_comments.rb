class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :post, index: true
      t.text :com_author
      t.text :com_content

      t.timestamps
    end
  end
end
