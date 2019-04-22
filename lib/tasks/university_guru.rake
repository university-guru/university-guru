namespace :university_guru do
  desc "Creates and seeds the database, then runs the server"
  task deploy: :environment do
	Rake::Task["db:setup"].invoke
	Process.exec("rails server")
  end
end
