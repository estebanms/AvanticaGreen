module DatesHelper
  def format_date(date)
    date.nil? ? '' : date.strftime('%a, %d %b %Y, %I:%M%p')
  end

  def format_date_only(date, week_day = true)
    date.nil? ? '' : date.strftime("#{week_day ? '%a, ' : ''}%d %b %Y")
  end

  def format_time_only(date)
    date.nil? ? '' : date.strftime('%I:%M%p')
  end
end