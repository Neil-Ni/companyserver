class AddManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :managers do |t|
      t.timestamps null: false
    end

    add_reference :managers, :team, index: true
    add_reference :managers, :user, index: true
  end
end
