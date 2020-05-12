# QueerHub
QueerHub is a blogging platform centering queer and trans content!


## Why am I creating this?
I have two main motivations for building QueerHub:
1. **Queer people are routinely targeted for harassment and violence online, and very few online spaces take steps to solve the problem systemically.** I wanted this to be queer-focused from its very inception, and have several planned features toward that goal:
  * Optional text filtering that will automatically scan, filter, and report all identifiable hate-speech.
  * Optional disabling of comment sections for any type of post.
  * Invite-only account model that encourages queer and trans folks to share this as a resource amongst each other.
1. 


## Highlights
* **I built an [Event Sourcing system](https://dev.to/isalevine/building-an-event-sourcing-system-in-rails-part-1-what-is-event-sourcing-46db) to track all changes to data, and serve as a publish-subscribe system!**

  All data changes are wrapped in a `Command` class, which validates data and creates an `Event`. 
  
  Each `Event` is then dispatched to a Sidekiq queue, which passes the event to any `Reactor` class listening for its target `event_type`.

  Some links to code examples:
  * `EventReactorDictionary` Singleton that [loads all classes in the `Reactor` namespace](https://github.com/isalevine/queerhub-web/blob/0fa5be523b7a7d1983ec7ff2df307dc838272d8d/app/services/event_reactor_dictionary.rb#L28), and builds a hash using those classes as keys pointing to `Events` which they react to. 
    * This is what the main Sidekiq worker uses [to dispatch queued Events to their Reactors](https://github.com/isalevine/queerhub-web/blob/0fa5be523b7a7d1983ec7ff2df307dc838272d8d/app/workers/event_dispatcher_worker.rb#L9): 
    * [Link to EventReactorDictionary class file](https://github.com/isalevine/queerhub-web/blob/master/app/services/event_reactor_dictionary.rb)
  * Encrypting sensitive params such as passwords with BCrypt [happens manually within the `Command` class, as part of its data validation](https://github.com/isalevine/queerhub-web/blob/0fa5be523b7a7d1983ec7ff2df307dc838272d8d/app/models/commands/user/create.rb#L22). 
    * Salted passwords must be generated earlier than using `has_secure_password` does, as the password data is stored in an `Event` record as well as a `User` record, and the salted passwords _must be the same_ in both records.
  * Examples of **separation of concerns**:
    * [`Events` are only concerned with applying changes to a particular model's instance](https://github.com/isalevine/queerhub-web/blob/master/app/models/events/user/created.rb)
    * [`Commands` are only concerned about validating data, and creating a new Event with it](https://github.com/isalevine/queerhub-web/blob/master/app/models/commands/user/create.rb#L26)
    * [`Reactors` only have to know which Event classes they are listening for,]((https://github.com/isalevine/queerhub-web/blob/0fa5be523b7a7d1983ec7ff2df307dc838272d8d/app/models/reactors/console_notification/user_created.rb#L16) and dispatching is [handled by a Sidekiq worker](https://github.com/isalevine/queerhub-web/blob/0fa5be523b7a7d1983ec7ff2df307dc838272d8d/app/workers/event_dispatcher_worker.rb#L9) along with [the EventReactorDictionary Singleton](https://github.com/isalevine/queerhub-web/blob/master/app/services/event_reactor_dictionary.rb)


* **I implemented test coverage for the Event Sourcing system with RSpec and DatabaseCleaner!**

  Because wrapping data changes in `Events` and `Commands` takes them outside the normal callback chain for ActiveRecord methods, actions like creating a new User via `Commands::User::Create` is not automatically rolled back by RSpec. 
  
  This leaves leftover data in the testing database, which interferes with processes such as validations for unique usernames.
  
  RSpec needs a tool like DatabaseCleaner [to ensure that a clean database is used in each test.](https://github.com/isalevine/queerhub-web/blob/master/spec/support/database_cleaner.rb)

  * [Tests for `Commands::User::Create`](https://github.com/isalevine/queerhub-web/blob/master/spec/models/commands/users/create_spec.rb)
  * [Tests for `Commands::USer::Destroy`](https://github.com/isalevine/queerhub-web/blob/master/spec/models/commands/users/destroy_spec.rb)

* **This project is the basis for [my step-by-step tutorial blog for creating an Event Sourcing system from scratch in Rails!](https://dev.to/isalevine/building-an-event-sourcing-pattern-in-rails-from-scratch-355h)**

* **I have started building Vue components and TailwindCSS themes for the frontend design!**

  This work is still in the early stages, but a reuseable Vue component is now configured to use custom-defined TailwindCSS styling.

  * The app itself [now boots a Vue instance on its index page](https://github.com/isalevine/queerhub-web/blob/master/app/views/v1/homepage/index.html.erb) to test Vue components and TailwindCSS styling
  * The Vue component is [a container called `queer-container`](https://github.com/isalevine/queerhub-web/blob/master/app/javascript/components/queer-container.vue) to establish reusable Vue code
  * The current TailwindCSS styling is very basic [trans flag colors: pink, blue, and white](https://github.com/isalevine/queerhub-web/blob/master/tailwind.config.js) to confirm styling is working as expected



# Setup
1. Clone repo.
1. In `queerhub-web` directory, run `rails s` to start Rails server.


# Features
## Event Sourcing
* Changes to state and data are recorded in immutable event objects


# Acknowledgments
Special thanks to Kickstarter and Philippe Creux for [their amazing Event Sourcing tutorial!](https://kickstarter.engineering/event-sourcing-made-simple-4a2625113224)