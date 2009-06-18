require 'config/environment'

class ObdReportRunner
  class << self
    def run
      ds = OBD::DataSource.new
      ds.files.each do |filename|
        if ds.timestamp(filename) < 30.days.ago
          ds.delete(filename)
        else
          unless File.exists?(OBD_PUBLISH_DIRECTORY + filename + OBD::PIPE_DELIMITED_EXT)
            ds.download(filename, OBD_CSV_DIRECTORY + filename)
            OBD::Report.publish(filename)
          end
        end
      end
    end
  end
end
      
if __FILE__ == $0
  OdbReportRunner.run
end
    
    