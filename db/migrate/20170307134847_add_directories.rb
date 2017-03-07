class AddDirectories < ActiveRecord::Migration[5.0]
  def change
    create_table :directories do |t|
      t.timestamps null: false
    end

    add_reference :directories, :company, index: true
    add_reference :directories, :user, index: true
  end
end
