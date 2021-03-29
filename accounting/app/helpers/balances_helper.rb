module BalancesHelper
  def balance_link(balance)
    link_to formatted_amount(balance.amount), balance_path(balance)
  end

  def formatted_amount(amount)
    as_float = (amount.to_f / 100).round(2)
    "#{as_float}$"
  end
end
