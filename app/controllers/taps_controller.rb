class TapsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:notify]

  def show
    @nfc_tag = NfcTag.find_by(token: params[:token], active: true)
    render file: "public/404.html", status: :not_found unless @nfc_tag
  end

  def notify
    nfc_tag = NfcTag.find_by(token: params[:token], active: true)
    return render json: { ok: false, error: "invalid token" }, status: :not_found unless nfc_tag

    user_name  = params[:user_name].to_s.strip
    event_type = params[:event_type].to_s.strip

    return render json: { ok: false, error: "user_name is required" }, status: :bad_request if user_name.blank?
    return render json: { ok: false, error: "invalid event_type" }, status: :bad_request unless %w[enter leave].include?(event_type)

    tap_log = nfc_tag.tap_logs.create!(
      tenant:     nfc_tag.tenant,
      user_name:  user_name,
      event_type: event_type,
      status:     "success",
      ip_address: request.remote_ip
    )

    SlackNotifier.notify(
      slack_config: nfc_tag.tenant.slack_config,
      user_name:    user_name,
      event_type:   event_type
    )

    render json: { ok: true }
  rescue => e
    Rails.logger.error("[Tap] #{e.class}: #{e.message}")
    render json: { ok: false, error: "internal error" }, status: :internal_server_error
  end
end
