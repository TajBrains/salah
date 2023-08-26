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
    context 'with current time after sunset' do
      it 'returns true when given time is fajr_iqamah' do
        expect(subject.active?(:fajr_iqamah)).to be true
      end

      it 'returns false when given time is fajr' do
        expect(subject.active?(:fajr)).to be false
      end

      it 'returns false when given time is dhuhr' do
        expect(subject.active?(:dhuhr)).to be false
      end

      it 'returns false when given time is asr' do
        expect(subject.active?(:asr)).to be false
      end

      it 'returns false when given time is maghrib' do
        expect(subject.active?(:maghrib)).to be false
      end

      it 'returns false when given time is isha' do
        expect(subject.active?(:isha)).to be false
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

    context 'with current time after fajr and before fajr iqamah' do
      before do
        Timecop.freeze(DateTime.new(now.year, now.month, now.day, 3, 26))
      end

      it 'returns false for fajr_iqamah' do
        expect(subject.active?(:fajr_iqamah)).to be false
      end

      it 'returns true for fajr' do
        expect(subject.active?(:fajr)).to be true
      end
    end
  end

  describe '.next_time' do
    it 'returns the next prayer time' do
      expect(subject.next_time).to eq pray_time.dhuhr
    end

    context 'with current time after fajr and before fajr iqamah' do
      before do
        Timecop.freeze(DateTime.new(now.year, now.month, now.day, 4, 30))
      end

      it 'returns fajr_iqamah time' do
        expect(subject.next_time).to eq pray_time.fajr_iqamah
      end
    end
  end

  describe '.next_time_name' do
    it 'returns the name of the next prayer time' do
      expect(subject.next_time_name.to_sym).to eq :dhuhr
    end

    context 'with current time after fajr and before fajr iqamah' do
      before do
        Timecop.freeze(DateTime.new(now.year, now.month, now.day, 4, 30))
      end

      it 'returns fajr_iqamah' do
        expect(subject.next_time_name.to_sym).to eq :fajr_iqamah
      end
    end
  end
end
