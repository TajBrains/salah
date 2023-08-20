# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users

  scope defaults: { locale: :en } do
    authenticated :user do
      mount Avo::Engine, at: Avo.configuration.root_path
      mount Sidekiq::Web => '/jobs'
    end
  end

  root 'main#index'
  post '/import', to: 'main#import'
end
