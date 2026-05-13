class NfcTag < ApplicationRecord
  belongs_to :tenant
  has_many   :tap_logs

  validates :tag_id,     presence: true
  validates :event_type, presence: true, inclusion: { in: %w[enter leave both] }
  validates :tag_id,     uniqueness: { scope: :tenant_id }
end
