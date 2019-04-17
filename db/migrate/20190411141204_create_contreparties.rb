class CreateContreparties < ActiveRecord::Migration[5.2]
  def change
    create_table :contreparties do |t|
      t.belongs_to :project, index: true
      t.string :name
      t.integer :amount
      t.boolean :stock_state, default: true
    end
  end
end
