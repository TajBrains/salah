class BackgroundResource < Avo::BaseResource
  self.title = :name
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :name, as: :text
  field :key, as: :text
  field :metadata, as: :key_value
  field :image, as: :file, is_image: true
end
