# encoding: UTF-8
require "spec_helper"

feature "import csv" do
  scenario "with only ascii" do
    visit members_path
    attach_file 'csv', File.join(File.dirname(__FILE__), 'fixtures/ascii.csv')
    click_button "Import"
    page.find("td:first").text.should == "Paul McMahon"
    page.find("td:last").text.should == "paul@mobalean.com"
  end

  scenario "with only utf-8" do
    visit members_path
    attach_file 'csv', File.join(File.dirname(__FILE__), 'fixtures/utf-8.csv')
    click_button "Import"
    page.find("td:first").text.should == "ポール"
    page.find("td:last").text.should == "paul@mobalean.com"
  end
end
