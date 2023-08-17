# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrayTimeService do
  let!(:pray_time) { create :pray_time }
  let!(:yesterday_pray_time) { create :pray_time, :yesterday }
  let!(:tomorrow_pray_time) { create :pray_time, :tomorrow }
  let(:now) { Date.current }

  subject { described_class.new(pray_time) }

  before do
    Timecop.freeze(DateTime.new(now.year, now.month, now.day, 10, 0))
  end

  describe '.active?' do
    context 'with current time after fajr' do
      it 'returns true when the time is active' do
        expect(subject.active?(:fajr)).to be true
      end

      it 'returns false when the time is not active' do
        expect(subject.active?(:asr)).to be false
      end
    end

    context 'with current time before fajr and after isha' do
      before do
        Timecop.freeze(DateTime.new(now.year, now.month, now.day, 21, 0))
      end

      it 'returns true when the time is active' do
        expect(subject.active?(:isha)).to be true
      end

      it 'returns false when the time is not active' do
        # Assuming asr time is not active right now
        expect(subject.active?(:fajr)).to be false
      end
    end

    context 'with current time before fajr and after 00 hour' do
      before do
        Timecop.freeze(DateTime.new(now.year, now.month, now.day, 0, 10))
      end

      it 'returns true when the time is active' do
        expect(subject.active?(:isha)).to be true
      end

      it 'returns false when the time is not active' do
        expect(subject.active?(:fajr)).to be false
      end
    end
  end

  describe '.next_time' do
    it 'returns the next prayer time' do
      expect(subject.next_time).to eq pray_time.dhuhr
    end
  end

  describe '.next_time_name' do
    it 'returns the name of the next prayer time' do
      expect(subject.next_time_name.to_sym).to eq :dhuhr
    end
  end
end
