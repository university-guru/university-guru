# frozen_string_literal: true

namespace :university_guru do
  desc 'Creates and seeds the database, then runs the server'
  task deploy: :environment do
    system 'bundle install'
    Rake::Task['db:setup'].invoke
    Rake::Task['assets:clean'].invoke
    puts "\n\n\nVisit localhost:3000 in a browser to see the application!\n\n\n"
    Process.exec('rails server')
  end
end
