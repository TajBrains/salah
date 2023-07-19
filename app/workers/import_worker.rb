class ImportWorker
	include Sidekiq::Worker

	def perform
		ImportService.import
	end
end
