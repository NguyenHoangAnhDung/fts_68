module FormatTime
  def format_time format
    strftime(I18n.t "time.formats.#{format}")
  end
end
Time.include FormatTime
