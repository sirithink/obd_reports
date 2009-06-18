module OBD
  
  OBD_FILE_PATTERN = "*.csv".freeze
  
  class DataSource 
    extend Forwardable
   
    def initialize()
      @ftp = Net::FTP.new(OBD_FTP_ADDRESS)
      @ftp.login(OBD_USERNAME, OBD_PASS)
      @ftp.chdir(OBD_DIRECTORY)
    end
  
    # Delegate to FTP methods
    def_delegator :@ftp, :gettextfile, :download
    def_delegator :@ftp, :mtime, :timestamp
    def_delegators :@ftp, :delete
  
    def files
      @ftp.nlst(OBD_FILE_PATTERN)
    end  
  
  end
end