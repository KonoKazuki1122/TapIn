tenant = Tenant.find_or_create_by!(name: "開発テスト株式会社") do |t|
  t.plan   = "free"
  t.active = true
end

tenant.create_slack_config!(
  webhook_url: "https://hooks.slack.com/services/dev/dummy",
  bot_name:    "TapIn"
) unless tenant.slack_config

unless tenant.nfc_tags.exists?
  tenant.nfc_tags.create!(label: "入口", event_type: "enter")
  tenant.nfc_tags.create!(label: "出口", event_type: "leave")
end

user = User.find_or_initialize_by(email: "kono.ziu.tech@gmail.com")
unless user.persisted?
  user.password              = "123456a"
  user.password_confirmation = "123456a"
  user.tenant                = tenant
  user.save!
end

puts "=== seed完了 ==="
puts "メール    : kono.ziu.tech@gmail.com"
puts "パスワード : 123456a"
puts "プラン    : #{tenant.plan}（dev画面から切り替え可能）"
