class Events::BaseEvent < ActiveRecord::Base
  # https://github.com/pcreux/event-sourcing-rails-todo-app-demo/blob/master/app/models/lib/base_event.rb

  before_validation :preset_aggregate
  before_create :apply_and_persist

  self.abstract_class = true



  def apply(aggregate)
    raise NotImplementedError
  end



  def aggregate=(model)
    public_send "#{aggregate_name}=", model
  end

  # Return the aggregate that the event will apply to
  def aggregate
    public_send aggregate_name
  end

  private def preset_aggregate
    # Build aggregate when the event is creating an aggregate
    self.aggregate ||= build_aggregate
  end

  def build_aggregate
    public_send "build_#{aggregate_name}"
  end

  def self.aggregate_name
    inferred_aggregate = reflect_on_all_associations(:belongs_to).first
    raise "Events must belong to an aggregate" if inferred_aggregate.nil?
    inferred_aggregate.name
  end

  delegate :aggregate_name, to: :class

  

  private def apply_and_persist
    # Lock the database row! (OK because we're in an ActiveRecord callback chain transaction)
    aggregate.lock! if aggregate.persisted?

    # Apply!
    self.aggregate = apply(aggregate)

    #Persist!
    aggregate.save!
    self.aggregate_id = aggregate.id if aggregate_id.nil?
  end

end