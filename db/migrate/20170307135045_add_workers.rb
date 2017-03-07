class AddWorkers < ActiveRecord::Migration[5.0]
  def change
    create_table :workers do |t|
      t.timestamps null: false
    end

    add_reference :workers, :team, index: true
    add_reference :workers, :user, index: true
  end
end
