class CreateNfcTags < ActiveRecord::Migration[7.1]
  def change
    create_table :nfc_tags do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string  :tag_id,     null: false
      t.string  :label
      t.string  :event_type, null: false
      t.boolean :active,     null: false, default: true

      t.timestamps
    end

    add_index :nfc_tags, [:tenant_id, :tag_id], unique: true
  end
end
