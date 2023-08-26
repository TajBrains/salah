require 'rails_helper'

RSpec.feature 'Turbo.visit behavior', type: :feature, js: true do
  let!(:pray_time) { create :pray_time }
  let!(:yesterday_pray_time) { create :pray_time, :yesterday }
  let!(:tomorrow_pray_time) { create :pray_time, :tomorrow }
  let(:now) { Date.current }

  before :each do
    Rails.application.load_seed

    visit '/'
  end

  scenario 'fajr Iqamah' do
    sleep 10
    # Freeze time to simulate a long period of inactivity
    Timecop.travel(DateTime.new(2023, 8, 21, 3, 26)) do
      visit '/'
      sleep 20
      within "#remained_time" do
        expect(page).to_not have_content('-')
      end
    end
  end

  scenario 'Ogle Azan' do
    sleep 10
    # Freeze time to simulate a long period of inactivity
    Timecop.travel(DateTime.new(2023, 8, 21, 11, 31)) do
      visit '/'
      sleep 20
      within "#remained_time" do
        expect(page).to_not have_content('-')
      end
    end
  end
end
