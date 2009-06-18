require 'rubygems'
require 'net/ftp'
require 'active_support'
require 'fastercsv'
require 'forwardable'

require 'lib/data_source'
require 'lib/report'

OBD_REPORT_HOME = Dir.pwd unless defined? OBD_REPORT_HOME
ENV['OBD_ENV'] ||= 'development'

require "config/environments/#{ENV['OBD_ENV']}"

