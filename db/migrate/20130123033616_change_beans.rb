class ChangeBeans < ActiveRecord::Migration
  def up
    add_column :beans, :user_id, :integer
    rename_column :beans, :is_checkout, :redeemed
  end

  def down
  end
end
