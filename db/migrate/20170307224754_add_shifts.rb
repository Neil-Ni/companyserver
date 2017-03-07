class AddShifts < ActiveRecord::Migration[5.0]
  def change
    create_table :shifts do |t|
      t.boolean :published, null: false, default: false
      t.datetime :start, null: false
      t.datetime :stop, null: false
      t.timestamps null: false
    end

    add_reference :shifts, :team, index: true
    add_reference :shifts, :job, index: true
    add_reference :shifts, :user, index: true
  end
end
