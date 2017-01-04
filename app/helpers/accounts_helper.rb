module AccountsHelper
  def return_color(confirmed, failures)
    if confirmed.nil? && failures.nil?
      return 'warning'
    elsif confirmed.present?
      return 'success'
    else
      return 'danger'
    end
  end

  def console(type)
    if type == 'PlayStation 4'
      'PS4'
    elsif type == 'Xbox One'
      'X1'
    elsif type == 'PlayStation 3'
      'PS3'
    else 
      'X360'
    end
  end
end
