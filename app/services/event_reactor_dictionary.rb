class EventReactorDictionary
  include Singleton

  # is this necessary? any other way to automatically call load_reactors?
  def initialize
    load_reactors
  end

  def load_reactors
    # load all classes in app/models/reactors
  end

  def self.call(event_type)
    # return array of Reactor classes to call with .each
  end

end