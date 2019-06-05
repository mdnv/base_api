module ApplicationHelper
  def show_date datetime
    datetime.strftime("%Y-%m-%d") if datetime
  end
end
