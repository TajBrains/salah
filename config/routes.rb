require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/jobs'

  root "main#index"
	post '/import', to: 'main#import'
end
