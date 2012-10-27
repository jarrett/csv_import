# CsvImport

This Rails plugin provides a controller method called each_csv_row and
an accompanying helper called csv_form.

By default, when each_csv_row is called, any exceptions raised in the
block will be rescued. The rows that triggered the exceptions will
then be displayed in a table as part of the output from csv_form.

You can turn off rescuing by calling each_csv_row(false).

Big thanks to [Doorkeeper](http://www.doorkeeperhq.com/) for their work
on this plugin.

## Compatibility

* Ruby 1.9
* Rails 3

## Usage

    # app/controllers/members_controller.rb

    class MembersController < ActionController::Base
      include CsvImport

      def create
        each_csv_row do |row|
          Member.create!(row)
        end
      end
    end

    # app/views/members/index.html.erb

    <h1>Import Members</h1>

    <%= csv_form members_path do %>

      <!-- whatever you put in the optional
      block will appear at the end of the form -->
    <% end %>
