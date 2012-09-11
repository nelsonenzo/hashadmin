require 'sinatra/activerecord/rake'
require './app' 

#stops heroku bitching about not know what default task is when you run heroku run rake on cedar
task :default => :spec
# Rake::Task[:default].clear if Rake::Task.task_defined?(:default)
