class TapLog < ApplicationRecord
  belongs_to :tenant
  belongs_to :nfc_tag

  validates :user_name,  presence: true
  validates :event_type, presence: true, inclusion: { in: %w[enter leave] }
  validates :status,     presence: true, inclusion: { in: %w[success skipped] }
end
