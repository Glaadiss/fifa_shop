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
end
