class CreateAddRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :add_requests do |t|
      t.references :user, foreign_key: true
      t.references :university, foreign_key: true
      t.text :content
      t.boolean :status

      t.timestamps
    end
  end
end
