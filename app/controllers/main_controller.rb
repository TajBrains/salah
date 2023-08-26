class MainController < ApplicationController
  layout 'times_screen'

  before_action :import_times, only: :index

  def index
    @version = params[:version] || :v1
    @pray_time = PrayTime.today
    @pray_time_service = PrayTimeService.new(@pray_time)
    @bg_image = Background.find_by(key: Setting.main[:background])
    @announcements = Announcement.active
  end

  private

  def import_times
    ImportService.import if PrayTime.today.nil?
  end
end
