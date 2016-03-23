# A very simple To-Do List
This is a very simple to-do list for practicing.

## How to use
1. Generate the model `to_do_list`
```
$ rails g model to_do_list name:string description:text is_public:bloolean importance:integer
```
2. Migrate
```
$ bin/rake db:migrate
```
3. Install gems
```
$ bundle install
```
4. Start the application
```
bin/rails server
```