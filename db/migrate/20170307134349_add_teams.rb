class AddTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false, default: ''
      t.string :timezone, null: false, default: ''
      t.string :day_week_starts, null: false, default: 'monday'
      t.string :color, null: false, default: '48B7AB'
      t.boolean :archived, null: false, default: false

      t.timestamps null: false
    end

    add_reference :teams, :company, index: true
  end
end
