module AccountsHelper
  def return_color(confirmed, failures)
    if confirmed.nil? && failures.nil?
      return 'info'
    elsif confirmed.present?
      return 'success'
    else
      return 'danger'
    end
  end
end
