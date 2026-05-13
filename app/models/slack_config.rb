class SlackConfig < ApplicationRecord
  belongs_to :tenant

  validates :webhook_url, presence: true
end
