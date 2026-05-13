class NfcTag < ApplicationRecord
  belongs_to :tenant
  has_many   :tap_logs

  before_create :generate_token

  validates :label,      presence: true
  validates :event_type, presence: true, inclusion: { in: %w[enter leave both] }
  validates :token,      uniqueness: true

  private

  def generate_token
    loop do
      self.token = SecureRandom.urlsafe_base64(8)
      break unless NfcTag.exists?(token: token)
    end
  end
end
