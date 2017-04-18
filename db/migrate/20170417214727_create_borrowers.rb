class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.integer :amount
      t.integer :amount_raised
      t.string :reason
      t.integer :user_id
      t.string :description

      t.timestamps null: false
    end
  end
end
