class AddDefaultTimeZoneToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :default_time_zone, :string, null: false, default: 'America/New_York'
  end
end
