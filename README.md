# README

Tech details:
* **Ruby**: 2.5.0
* **Rails**: 5.2.0
* **Postgresql**: 9.5

Steps to run:
* Install ruby `2.5.0` (from source or rvm, both works)
* Install bundler for the ruby: `gem install bundler`
* Run `bundle install`
* Install `postgresql` database(if not installed already) or connect with remote database by updating `database.yml` file
* Update `database.yml` file with corresponding credentials of the database user you want to use
* Run `rails db:setup` or `rake db:setup`
* Run `rails s` or `rails server`
* Open browser and visit `localhost:3000` (or `localhost:[port_defined_by_you]`)

Steps to run **tests**
* Go to project directory
* Run `rspec -f documentation spec/` (`-f documentation` is for output format as documentation. You may try other options too.)
