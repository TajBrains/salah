# frozen_string_literal: true

require 'google/cloud/secret_manager'

class GoogleBucketConfig < ApplicationConfig
  attr_config :data

  def initialize
    super

    return if @secrets_fetched

    client = Google::Cloud::SecretManager.secret_manager_service

    secret_name = 'projects/695060845805/secrets/bucket_accessor/versions/latest'

    begin
      secret_version = client.access_secret_version(name: secret_name)
      secret_payload = secret_version.payload.data.to_s
      @secrets_fetched = true

      secret_data = JSON.parse(secret_payload)
      self.data = secret_data
    rescue Google::Cloud::Error => e
      # Handle error fetching secrets
      puts "Error fetching secrets: #{e.message}"
    end
  end
end
