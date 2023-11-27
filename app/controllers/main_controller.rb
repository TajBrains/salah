# frozen_string_literal: true

class MainController < ApplicationController
  layout 'times_screen'

  before_action :set_location, only: :index
  before_action :import_times, only: :index

  def index
    @pray_time = PrayTime.for_location(@location).today
    @pray_time_service = PrayTimeService.new(@pray_time, @location)
    @bg_image = Background.find_by(key: Setting.main[:background])
  end

  private

  def set_location
    @location = request.subdomain.nil? | request.subdomain.empty? ? :stuttgart : request.subdomain
  end

  def import_times
    return unless PrayTime.for_location(@location).today.nil? || PrayTime.for_location(@location).tomorrow.nil?

    ImportService.import(@location)
  end
end
