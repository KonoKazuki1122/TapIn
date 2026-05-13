class CreateSlackConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :slack_configs do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :webhook_url, null: false
      t.string :channel_name
      t.string :bot_name,    default: "TapIn"
      t.text :enter_message
      t.text :leave_message
      t.string :allowed_ip_range

      t.timestamps
    end
  end
end
