class CreateRaffles < ActiveRecord::Migration
  def change
    create_table :raffles do |t|
      t.integer :num_of_winner
      t.string :name
      t.text :description
      t.datetime :drawing_time
      t.boolean :repeat
      t.text :instructions
      t.belongs_to :merchant
      t.timestamps
    end
    add_index :raffles, :merchant_id
  end
end
