class StaticController < ApplicationController
  skip_before_action :authorize

  def not_authorized
  end
end
