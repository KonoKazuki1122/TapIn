class ApplicationController < ActionController::Base
  private

  def current_tenant
    current_user&.tenant
  end
  helper_method :current_tenant
end
