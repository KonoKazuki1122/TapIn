class SlackConfigsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @slack_config = current_tenant.slack_config || current_tenant.build_slack_config
  end

  def update
    @slack_config = current_tenant.slack_config || current_tenant.build_slack_config
    if @slack_config.update(slack_config_params)
      redirect_to dashboard_path, notice: "Slack設定を保存しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def slack_config_params
    params.require(:slack_config).permit(:webhook_url, :channel_name, :bot_name, :enter_message, :leave_message, :allowed_ip_range)
  end
end
