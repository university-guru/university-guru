# University Guru
**University Guru** is the product of an Agile software development project for an introductory software engineering course at Miami University.  The goal of the project was to design a web application that allows users to view, search for, and filter through information about universities in the United States.

## Build Status
[![Build Status](https://travis-ci.org/university-guru/university-guru.svg?branch=master)](https://travis-ci.org/university-guru/university-guru)

## Building the Project
In order to build this project, Ruby ([ruby-lang.org](https://www.ruby-lang.org/en/)) - specifically version 2.6.1 - and PostgreSQL ([postgresql.org](https://www.postgresql.org/download/)).

To install Ruby, follow the instructions on Ruby's site for your specific operating system.  Make sure the version you download is version 2.6.1 and that it includes the Ruby DevKit (this will be used when compiling C libraries).  Ensure your Ruby `bin/` folder gets added to your `PATH`.

To install Postgres, follow the instructions on Postgres's site for your operating
system.

When both Ruby and PostgreSQL are installed, clone this repository (or download it
as a ZIP file and extract it).  Using PowerShell (Windows) or Terminal (MacOS
and Linux), navigate to that directory.

Run the following to download dependencies and run the server:

```sh
bundle exec rake university_guru:deploy
```

Finally, visit [localhost:3000](http://localhost:3000) in your browser to view
your running application.
