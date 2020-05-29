# TODO: Consider moving this class to lib?
class EventReactorDictionary

  attr_accessor :dictionary

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
      event_type = reactor.target_event_type.to_s
      dictionary[event_type] ||= []
      dictionary[event_type] << reactor unless dictionary[event_type].include?(reactor.class)
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
    self.dictionary[event_type]
  end

end
