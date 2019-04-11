class CreateContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contributions do |t|
      t.belongs_to :users, index: true
      t.belongs_to :projects, index: true
      t.timestamps
    end
  end
end
