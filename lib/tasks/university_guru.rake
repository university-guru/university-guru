# frozen_string_literal: true

namespace :university_guru do
  desc 'Creates and seeds the database, then runs the server'
  task deploy: :environment do
    Process.exec('bundle install')
    Rake::Task['db:setup'].invoke
    Process.exec('rails server')
  end
end
