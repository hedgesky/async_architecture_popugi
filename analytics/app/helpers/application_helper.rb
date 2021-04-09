module ApplicationHelper
  def formatted_amount(amount)
    as_float = (amount.to_f / 100).round(2)
    "#{as_float}$"
  end
end
