class AddCreatedAtToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :created_at, :datetime, null: false
  end
end
