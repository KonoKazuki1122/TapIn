class ReplaceTagIdWithTokenInNfcTags < ActiveRecord::Migration[7.1]
  def change
    remove_index  :nfc_tags, [:tenant_id, :tag_id]
    remove_column :nfc_tags, :tag_id, :string

    add_column :nfc_tags, :token, :string, null: false, default: ""
    add_index  :nfc_tags, :token, unique: true
  end
end
