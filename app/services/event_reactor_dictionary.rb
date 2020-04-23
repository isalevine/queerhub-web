# TODO: Consider moving this class to lib?
class EventReactorDictionary

  attr_accessor :reactors

  # per this article, functionally a Singleton (https://stackoverflow.com/a/10733789)
  def self.instance
    @@instance ||= new
  end

  def initialize
    self.dictionary = build_dictionary
  end

  def build_dictionary
    dictionary = {}
    reactors = load_reactors
    reactors.each do |reactor|
      reactor_name = reactor.to_s
      dictionary[reactor_name] = [] if dictionary[reactor_name].nil?
      dictionary[reactor_name] << reactor.target_event_type unless dictionary[reactor_name].include?(reactor.target_event_type)
    end
    dictionary
  end
  
  def load_reactors
    reactors = []
    Reactors.constants.each do |reactor_module|
      if reactor_module != :BaseReactor
        namespace = "Reactors::#{reactor_module.to_s}".constantize
        namespace.constants.each do |reactor|
          if reactor != :BaseReactor
            reactors << "#{namespace}::#{reactor}".constantize
          end
        end
      end
    end
    reactors
  end
  
  def call(event_type)
    self.reactors[event_type]
    # return array of Reactor classes to call with .each
  end

end