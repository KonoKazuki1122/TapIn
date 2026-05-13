class CreateTapLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :tap_logs do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :nfc_tag, null: false, foreign_key: true
      t.string :user_name,  null: false
      t.string :event_type, null: false
      t.string :status,     null: false
      t.string :skip_reason
      t.string :ip_address

      t.timestamps
    end
  end
end
