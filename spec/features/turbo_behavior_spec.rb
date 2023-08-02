require 'rails_helper'

RSpec.feature 'Turbo.visit behavior', type: :feature, js: true do
  let(:now) { Date.current }

  scenario 'should handle long inactivity' do
    visit '/'

    sleep 5

    page.execute_script("window.resizeTo(window.screen.width, window.screen.height);")

    # Freeze time to simulate a long period of inactivity
    Timecop.travel(Time.current + 36.minutes) do
      visit '/'
      sleep 70
      within "#remained_time" do
        expect(page).to_not have_content('-')
      end
    end
  end
end
