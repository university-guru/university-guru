@echo off

echo Restarting the PostgreSQL service...
set data_dir="%POSTGRES_INSTALL%\data"
pg_ctl -D %data_dir% restart

echo Setting up necessary database elements...
set query_db="CREATE DATABASE %USERNAME%;"
set query_role="CREATE ROLE %USERNAME%;"
set query_alter_login="ALTER ROLE %USERNAME% WITH LOGIN;"
set query_alter_createdb="ALTER ROLE %USERNAME% CREATEDB;"
psql -U postgres -c %query_db%
psql -U postgres -c %query_role%
psql -U postgres -c %query_alter_login%
psql -U postgres -c %query_alter_createdb%

echo Setting up Ruby on Rails...
call gem uninstall bcrypt
call gem install bcrypt --platform=ruby
bundle exec rake university_guru:deploy
