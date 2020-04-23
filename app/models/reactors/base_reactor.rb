class Reactors::BaseReactor
  attr_accessor :event

  def initialize(event)
    self.event = event
  end

  def call
    raise NotImplementedError
  end

  def self.target_event_type
    raise NotImplementedError
  end
end