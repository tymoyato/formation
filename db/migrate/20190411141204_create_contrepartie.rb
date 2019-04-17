class CreateContrepartie < ActiveRecord::Migration[5.2]
  def change
    create_table :contreparties do |t|
      t.belongs_to :contribution
      t.string :name
      t.integer :amount
      t.boolean :stock_state, default: true
    end
  end
end
