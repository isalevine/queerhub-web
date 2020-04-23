class Reactors::ConsoleNotification::UserCreated < Reactors::ConsoleNotification::BaseReactor
  def call
    puts <<~STR


      ===========================================
      User id #{self.event.user_id} created! 
      name: #{self.event.payload["name"]}
      email: #{self.event.payload["email"]}
      ===========================================

      
    STR
  end

  def self.target_event_type
    Events::User::Created
  end
end