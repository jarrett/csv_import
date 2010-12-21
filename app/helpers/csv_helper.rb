module CsvHelper
  # The optional block allows you to pass in extra HTML that will be inserted after the CSV form fields but before the submit button.
  def csv_form(url_for_options = {}, &block)
    if block_given?
      other_html = capture(&block)
    else
      other_html = nil
    end
    render :partial => 'csv_import/csv', :locals => {:url_for_options => url_for_options, :other_html => other_html}
  end
end
