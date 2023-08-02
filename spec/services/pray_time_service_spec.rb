require 'rails_helper'

RSpec.describe PrayTimeService do
	let(:today_pray_time) { create :pray_time }
	let(:yesterday_pray_time) { create :pray_time }

	describe ".is_active?" do
		context 'with current time after fajr' do
			before do
				now = DateTime.current
				Timecop.freeze(DateTime.new(now.year, now.month, now.day, 8, 0))
			end

			it "returns true when the time is active" do
				expect(PrayTimeService.is_active?(pray_time, :fajr)).to be true
			end

			it "returns false when the time is not active" do
				expect(PrayTimeService.is_active?(pray_time, :asr)).to be false
			end
		end

		context 'with current time before fajr and after isha' do
			before do
				now = DateTime.current
				Timecop.freeze(DateTime.new(now.year, now.month, now.day, 21, 0))
			end

			it "returns true when the time is active" do
				expect(PrayTimeService.is_active?(pray_time, :isha)).to be true
			end

			it "returns false when the time is not active" do
				# Assuming asr time is not active right now
				expect(PrayTimeService.is_active?(pray_time, :fajr)).to be false
			end
		end


		after do
			Timecop.return
		end
	end

	describe ".next_time" do
		it "returns the next prayer time" do
			# Assuming the current time is before dhuhr, the next time should be dhuhr.
			expect(PrayTimeService.next_time(pray_time)).to eq pray_time.dhuhr
		end
	end

	describe ".next_time_name" do
		it "returns the name of the next prayer time" do
			# Assuming the current time is before dhuhr, the next time name should be :dhuhr.
			expect(PrayTimeService.next_time_name(pray_time).to_sym).to eq :dhuhr
		end
	end

	describe ".active_time" do
		it "returns the currently active prayer time" do
			# Assuming fajr is the active prayer time right now
			expect(PrayTimeService.active_time(pray_time)).to eq pray_time.fajr
		end
	end

	describe ".times" do
		it "returns an array of formatted prayer times" do
			expect(PrayTimeService.times(pray_time)).to be_an(Array)
			expect(PrayTimeService.times(pray_time).length).to eq PrayTimeService::PRAY_TIMES_ORDER.length
		end
	end

	describe ".times_as_array" do
		it "returns an array of prayer times with labels and activity status" do
			expect(PrayTimeService.times_as_array(pray_time)).to be_an(Array)
			expect(PrayTimeService.times_as_array(pray_time).length).to eq PrayTimeService::PRAY_TIMES_ORDER.length
		end
	end
end
