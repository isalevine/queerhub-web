class EventDispatcherWorker
  include Sidekiq::Worker

  def perform(event_id, event_type)
    # convert event_type to Event:: class name,
    # and look up with .where(id: event_id)
  end
end