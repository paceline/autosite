class ImportUpdatesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Provider.where.not(token: [nil, ""]).each do |p|
      p.sync
    end
    reschedule_job
  end

  def reschedule_job
    self.class.set(wait: 5.minutes).perform_later
  end

end
