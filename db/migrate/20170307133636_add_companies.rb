class AddCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false, default: ''
      t.string :default_day_week_starts, null: false, default: 'monday'
      t.boolean :archived, null: false, default: false

      t.timestamps null: false
    end
  end
end
