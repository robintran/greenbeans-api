class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.belongs_to :raffle
      t.text :tier, default: { first: 0, second: 0, third: 0 }.to_yaml
      t.string :p_type

      t.timestamps
    end
    add_index :prizes, :raffle_id
  end
end
