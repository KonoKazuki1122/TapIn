class CreateTenants < ActiveRecord::Migration[7.1]
  def change
    create_table :tenants do |t|
      t.string  :name,   null: false
      t.string  :plan,   null: false, default: "free"
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
