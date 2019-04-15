class CreateContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contributions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
      t.integer :amount
      t.timestamps
    end
  end
end
