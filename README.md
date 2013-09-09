== Response test

When building a simple API app I came across what may be a bug?

When expecting a 200 response from widgets#create it changes to a 500 response but still renders the view content, no exception raised.

Files of note:
- app/controllers/widgets_controller.rb
- spec/controllers/widgets_controller_spec.rb
- app/controllers/application_controller.rb : decent_exposure configuration for strong params., rescue for ActionController::ParameterMissing

run `bundle exec rspec` and it will start a pry session where the response goes awry. Inspect the response with `response.status` and `response.body` to see that it is 500-ing but has not raised a visual error, still renders the JSON.