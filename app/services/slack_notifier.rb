require "net/http"
require "json"

class SlackNotifier
  def self.notify(slack_config:, user_name:, event_type:)
    return unless slack_config&.webhook_url.present?

    message = build_message(slack_config, user_name, event_type)
    post!(slack_config.webhook_url, message)
  end

  def self.post!(webhook_url, message)
    uri     = URI(webhook_url)
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request.body = { text: message }.to_json

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end

  def self.build_message(slack_config, user_name, event_type)
    template = event_type == "enter" ? slack_config.enter_message : slack_config.leave_message

    if template.present?
      template.gsub("{name}", user_name)
    elsif event_type == "enter"
      "🟢 入室 #{user_name} さん"
    else
      "🔴 退室 #{user_name} さん"
    end
  end
  private_class_method :build_message
end
