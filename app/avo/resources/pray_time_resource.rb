class PrayTimeResource < Avo::BaseResource
  self.title = :date
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :date, as: :date, sortable: true
  field :fajr, as: :date_time
  field :sunset, as: :date_time
  field :dhuhr, as: :date_time
  field :asr, as: :date_time
  field :maghrib, as: :date_time
  field :isha, as: :date_time
end
