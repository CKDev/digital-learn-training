class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    logger.info('Running sidekiq job')
  end
end
