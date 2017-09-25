class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.text :author
      t.text :datestamp

      t.timestamp
    end
  end
end
