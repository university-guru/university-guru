# University Guru
**University Guru** is the product of an Agile software development project for an introductory software engineering course at Miami University.  The goal of the project was to design a web application that allows users to view, search for, and filter through information about universities in the United States.

## Build Status
[![Build Status](https://travis-ci.org/university-guru/university-guru.svg?branch=master)](https://travis-ci.org/university-guru/university-guru)

## Building the Project
In order to build this project, Ruby ([ruby-lang.org](https://www.ruby-lang.org/en/)) - specifically version 2.6.1 - and PostgreSQL ([postgresql.org](https://www.postgresql.org/download/)).

### Installing Ruby
To install Ruby, follow the instructions on Ruby's site for your specific operating system.  Make sure the version you download is version 2.6.1 and that it includes the Ruby DevKit (this will be used when compiling C libraries).  Ensure your Ruby `bin/` folder gets added to your `PATH` environment variable.

### Installing PostgreSQL
To install Postgres, follow the instructions on Postgres's site for your operating system.  The specific version does not matter, so download and install the latest version.  If you are on a Mac/Linux machine, there are no further steps to complete.

#### PostgreSQL on Windows
Postgres requires a few extra steps when running on a Windows machine.  First of all, we must allow Ruby on Rails to access local databases.  To do this, we must navigate to our Postgres installation directory.
This should be `C:\Program Files\PostgreSQL\VERSION\`, where `VERSION` is the version of Postgres you installed.  Add this to an environment variable called `POSTGRES_INSTALL`.  Then, within this directory, open `data\pg_hba.conf` in a text editor.  Near the bottom of the file,
there should be several lines that end in `md5`.  Change every instance of `md5` to `trust`.  Save and close the file.

### Running the Server

When both Ruby and PostgreSQL are installed, clone this repository (or download it
as a ZIP file and extract it).  Using PowerShell (Windows) or Terminal (MacOS
and Linux), navigate to that directory.

Run the following to download dependencies and run the server:

#### Windows

```sh
./bin/server.bat
```

#### Mac/Linux

```sh
bundle exec rake university_guru:deploy
```

Finally, visit [localhost:3000](http://localhost:3000) in your browser to view
your running application.

_For the purposes of this assignment, a **Super User** account is automatically created during setup to allow for testing of the administrative/moderator dashboards (email: `superuser@example.com`, password: `password`).  This user is both a moderator and an administrator_
