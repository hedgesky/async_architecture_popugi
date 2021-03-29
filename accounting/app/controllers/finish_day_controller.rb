class FinishDayController < ApplicationController
  def create
    FinishDay.new.call
    redirect_to root_url, notice: 'Day has passed'
  end
end
