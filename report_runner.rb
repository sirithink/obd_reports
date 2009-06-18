require 'config/environment'

module OBD
  class ReportRunner
    class << self
      def run
        ds = DataSource.new
        ds.files.each do |filename|
          if ds.timestamp(filename) < 30.days.ago
            ds.delete(filename)
          else
            unless File.exists?(OBD_PUBLISH_DIRECTORY + filename + PIPE_DELIMITED_EXT)
              ds.download(filename, OBD_CSV_DIRECTORY + filename)
              Report.publish(filename)
            end
          end
        end
      end
    end
  end
end
      
if __FILE__ == $0
  OBD::ReportRunner.run
end
    
    