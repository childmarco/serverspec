require 'spec_helper'
require 'yaml'
require 'json'
require 'csv'
require 'specinfra'
require 'pry'

# require_relative '../../helpers/directory_helper'
# include DirectoryHelper


oracle_parameters = YAML.load_file(File.join(__dir__, '../../property/mw/oracle/oracle.yml'))
init_parameters   = oracle_parameters['init_parameter']


describe "sample" do
  var    = command("cat /home/vagrant/sample")
  hash   = Hash.new
  sample = var.stdout.each_line { |line|
    hash.store(line.chomp.split(":")[0], line.chomp.split(":")[1])
  }

  # binding.pry
end

describe "sample1" do
  var1  = command("su - vagrant -c 'cat /proc/cpuinfo'")
  hash1 = Hash.new
  var1.stdout.each_line { |line|
    line.chomp!
    parameter = line.split(":")[0]
    parameter.strip! unless parameter.nil?

    value = line.split(":")[1]
    value.strip! unless value.nil?

    hash1.store(parameter, value)
  }

  binding.pry
end

# describe "=======<Oracle> Init parameter=======" do
#   actual_parameters = backend.run_command('
#   su - oracle -c "sqlplus -s / as sysdba <<EOF
#       set lin 1000
#       set pages 0
#       set trims on
#       set tab off
#       select NAME||\',\'||VALUE line from v\\\\\\$parameter order by num ;
#       exit
#       EOF
#     "')

# describe command('su - oracle -c "sqlplus -s / as sysdba <<EOF
#     set lin 1000
#     set pages 0
#     set trims on
#     set tab off
#     select NAME||\',\'||VALUE line from v\\\\\\$parameter order by num ;
#     exit
#     EOF
#   "') do

binding.pry


init_parameters.each do |key, value|
  key.each do |para, val|
    # its(:stdout) { should match /#{para},#{val}/ }
  end
  # end
  # its(:stdout) { should match /processes,1000/ }
  # end
end


# directory = YAML.load_file('../../../property/os/directory.yml')
# directory = YAML.load_file('directory.yml')
# directories = YAML.load_file(File.join(__dir__, '../../property/mw/oracle/oracle.yml'))
# p directories
# p directories['init_parameter']
# directories['init_parameter'].each do |key, value|
#   key.each do |para, val|
#     p /#{para},#{val}/
#   end
# end

# p File.expand_path(File.dirname(__FILE__))
# p File.dirname(__FILE__)
# File.open(File.dirname(__FILE__)+'/../../../property/os/directory.json') do |file|
# hash = Hash.new
# File.open(File.expand_path('../../../property/os/directory.json', __FILE__)) do |file|
#   hash = JSON.load(file)
# end


# p "Hello, this is oracle spec rb"


# csv_directories=CSV.read(File.expand_path('../../../property/os/directory.csv', __FILE__), headers:true)
# csv_directories.each do |directory|
# 	unless directory["path"].nil?
# 		p directory["path"]
# 	end
# end

# CSV.foreach(File.expand_path('../../../property/os/directory.csv', __FILE__), headers: true) do |row|
#   unless row["path"].nil?
#     p row["path"]
# p row["owner"]
# end
# end


# p hash['localhost']


# p DirectoryHelper.get_roles(File.expand_path('../../../property/os/directory.json',__FILE__))
# p DirectoryHelper.get_roles(File.expand_path('../../../property/os/directory.json',__FILE__))

# s = "hello,\nworld\r\n"
# puts s.gsub(/(\r\n|\r|\n)/, "<br />")


# describe "Check Directory" do
# 	hash['localhost'].each do |value|
# 		describe file(value["directory"]) do
# 			it { should be_directory }
# 			it { should be_owned_by(value["owner"]) }
# 			it { should be_grouped_into(value["group"]) }
# 			it { should be_mode value["permission"] }
# 		end
#
# 	end
# end

