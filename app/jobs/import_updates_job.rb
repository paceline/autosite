class ImportUpdatesJob < ApplicationJob

  def perform(*args)
    reschedule_job
    Provider.where.not(token: [nil, ""]).each do |p|
      p.sync
    end
  end

  def reschedule_job
    self.class.set(wait: 24.hours).perform_later
  end

end
