class Dev::PlanSwitcherController < ApplicationController
  before_action :authenticate_user!
  before_action { raise "dev only" unless Rails.env.development? }

  def update
    current_tenant.update!(plan: params[:plan])
    redirect_back fallback_location: dashboard_path
  end
end
