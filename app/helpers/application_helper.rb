# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    bootstrap_alert_class = {
      'success' => 'alert-success',
      'error' => 'alert-danger',
      'notice' => 'alert-info',
      'alert' => 'alert-danger',
      'warn' => 'alert-warning'
    }
    bootstrap_alert_class[level]
  end

  def active_class(path)
    return 'active' if request.path == path

    ''
  end
end
