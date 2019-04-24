class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.belongs_to :category, index: true
      t.string :name
      t.text :short_desc
      t.text :long_desc
      t.integer :amount
      t.integer :percentage
      t.text :landscape_data
      t.text :thumb_data
    end
  end
end
