class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tenant      = current_user.tenant
    @nfc_tags    = @tenant.nfc_tags
    @slack_config = @tenant.slack_config
  end
end
