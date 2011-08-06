if RUBY_VERSION =~ /1.8/
  require 'fastercsv'
else
  require 'csv'
end

# Include this in a controller
module CsvImport
  DEFAULT_PARSE_OPTS = { :headers => true, :header_converters => :symbol }

  private

  def each_csv_row(opts = {})
    @rows_imported = 0
    @bad_csv = false
    @bad_rows = []
    @unknown_headers = Set.new
    @imported = false

    if request.post?
      ActiveRecord::Base.transaction do
        ::Rails.logger.info("starting csv import")
        valid_headers = opts.delete(:valid_headers)

        begin
          (RUBY_VERSION =~ /1.8/ ?  FasterCSV : CSV).parse(params[:csv].read, DEFAULT_PARSE_OPTS.merge(opts)) do |row|
            begin
              row_data = row.to_hash
              if valid_headers
                row_data.delete_if {|header, value| ! valid_headers.include?(header) }
                @unknown_headers.merge(row.headers - row_data.keys)
              end
              obj = yield row_data
              obj.save! if obj && (obj.new_record? || obj.changed?)
              @rows_imported += 1
            rescue ActiveRecord::ActiveRecordError, ActiveRecord::UnknownAttributeError => exc
              row[:error] = exc
              @bad_rows << row
            end
          end

          if @bad_rows.empty? && (@unknown_headers.empty? || params[:csv_ignore_unknown_columns])
            @imported = true
          end
        rescue
          @bad_csv = true
        end

        unless @imported
          ::Rails.logger.info("rolling back csv import, contained errors")
          raise ActiveRecord::Rollback
        end
      end
    end
  end
end
