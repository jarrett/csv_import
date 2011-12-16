class MembersController < ApplicationController
  include CsvImport
  def index
    @members = Member.all
  end
  def create
    each_csv_row do |row|
      email = row[:email].to_s.strip
      Member.find_or_create_by_email(email).tap do |member|
        member.update_attributes!(row)
      end
    end
    redirect_to action: :index
  end
end
