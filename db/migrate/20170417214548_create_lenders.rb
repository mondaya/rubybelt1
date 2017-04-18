class CreateLenders < ActiveRecord::Migration
  def change
    create_table :lenders do |t|
      t.integer :amount
      t.integer :amount_lent
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
