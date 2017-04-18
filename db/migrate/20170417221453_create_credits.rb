class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :lender_id
      t.integer :borrower_id
      t.integer :amount

      t.timestamps null: false
    end
  end
end
