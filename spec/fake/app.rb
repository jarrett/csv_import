require 'rails'
require 'active_record'
require 'action_controller/railtie'
require 'action_view/railtie'

ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('test')

app = Class.new(Rails::Application)
app.config.root = File.dirname(__FILE__)
app.config.secret_token = "3b7cd727ee24e8444053437c36cc66c4"
app.config.session_store :cookie_store, :key => "_myapp_session"
app.config.active_support.deprecation = :log
app.config.action_dispatch.show_exceptions = false

app.initialize!

app.routes.draw do
  resources :members
end
Class.new(ActiveRecord::Migration) do
  def self.up
    create_table(:members) {|t| t.string :email; t.string :name }
    add_index :members, :email, :unique => true
  end
end.up

