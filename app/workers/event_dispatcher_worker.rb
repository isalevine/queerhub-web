class EventDispatcherWorker
  include Sidekiq::Worker

  def perform(event_id, event_type)
    event = event_type.constantize.where(id: event_id)
    reactors = EventReactorDictionary.call(event_type)
    reactors.each do |reactor|
      reactor.new(event).call
    end
  end
end