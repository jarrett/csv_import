require 'csv'

# Include this in a controller
module CsvImport
	def each_csv_row(rescue_exceptions = true)
		if request.post?
			@rows_imported = 0
			ActiveRecord::Base.transaction do
				bad = false
				unless params['field_names_in_first_row'] == '1'
					@field_names = []
				end
				CSV.parse(params['csv'].read).each_with_index do |row, i|
					if i == 0 and params['field_names_in_first_row'] == '1'
						@field_names = row
					else
						if rescue_exceptions
							begin
								yield row
								@rows_imported += 1
							rescue Exception => exc
								@bad_rows ||= []
								@bad_rows << (row + [exc])
								bad = true
							end
						else
							yield row
							@rows_imported += 1
						end
					end
				end
				raise ActiveRecord::Rollback if bad
			end
		end
	end
end
