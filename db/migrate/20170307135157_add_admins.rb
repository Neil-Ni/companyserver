class AddAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.timestamps null: false
    end

    add_reference :admins, :company, index: true
    add_reference :admins, :user, index: true
  end
end
