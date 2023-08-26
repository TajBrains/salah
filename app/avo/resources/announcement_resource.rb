class AnnouncementResource < Avo::BaseResource
  self.title = :name
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :title, as: :text
  field :body, as: :textarea
  field :show_duration, as: :number
  field :active, as: :boolean
end
