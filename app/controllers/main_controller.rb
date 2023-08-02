class MainController < ApplicationController
  before_action :import_times, only: :index

  def index
    @version = params[:version] || :v1
    @pray_time = PrayTime.today
    @pray_time_service = PrayTimeService.new(@pray_time)
  end

  def import
    ImportWorker.perform_async

    redirect_to root_path
  end

  private

  def import_times
    ImportService.import if PrayTime.all.size == 0
  end
end
