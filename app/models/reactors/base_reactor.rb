class Reactors::BaseReactor
  def initialize(event)
    self.event = event
  end

  def call
    raise NotImplementedError
  end

  def target_event_type
    self.event.event_type
  end
end