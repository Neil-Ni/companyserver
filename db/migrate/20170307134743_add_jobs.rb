class AddJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :name, null: false, default: ''
      t.string :color, null: false, default: '48B7AB'

      t.timestamps null: false
    end

    add_reference :jobs, :team, index: true
  end
end
