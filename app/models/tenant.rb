class Tenant < ApplicationRecord
  has_one  :slack_config
  has_many :nfc_tags
  has_many :tap_logs

  validates :name, presence: true
  validates :plan, presence: true, inclusion: { in: %w[free standard pro] }
end
