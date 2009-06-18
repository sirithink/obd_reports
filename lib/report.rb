module OBD
  
  PARSE_ERROR = "Could not process CSV file: ".freeze
  PIPE_DELIMITED_EXT = ".dat".freeze
  
  class Report
    # Class methods
    class << self
      def publish(filename)
        report = Report.new
        report.to_pipe_delimited(filename)
        return true
      end
    end  
  
    def to_pipe_delimited(filename)
      pipe_file = OBD_PUBLISH_DIRECTORY + filename + PIPE_DELIMITED_EXT
      FasterCSV.open(pipe_file, "w", :col_sep => "|") do |csv|
        begin
          FasterCSV.foreach(OBD_CSV_DIRECTORY + filename) do |row|
            csv << row
          end  
        rescue Exception
          puts PARSE_ERROR + "#{filename}"
          clean_up(pipe_file)
        end
      end
    end
    
    private
    def clean_up(filename)
      File.delete(filename) unless not File.exists?(filename)
    end
  end
  
end