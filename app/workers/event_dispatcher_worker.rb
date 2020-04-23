# Remember to boot Sidekiq in development with `bundle exec sidekiq -e development`
# (https://stackoverflow.com/a/17220726)

class EventDispatcherWorker
  include Sidekiq::Worker

  def perform(event_id, event_type)
    event = event_type.constantize.find_by(id: event_id)
    reactors = EventReactorDictionary.instance.call(event_type)
    reactors.each do |reactor|
      reactor.new(event).call
    end
  end
end