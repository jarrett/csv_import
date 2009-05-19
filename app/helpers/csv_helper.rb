module CsvHelper
	# The optional block allows you to pass in extra HTML that will be inserted after the CSV form fields but before the submit button.
	def csv_form(&block)
		if block_given?
			other_html = capture(&block)
		else
			other_html = nil
		end
		concat(render(:partial => 'csv_import/csv', :locals => {:other_html => other_html}))
	end
end