require 'spec_helper'
require 'yaml'
require 'json'
require 'csv'

require_relative '../../helpers/directory_helper'
include DirectoryHelper

# directory = YAML.load_file('../../../property/os/directory.yml')
# directory = YAML.load_file('directory.yml')
# directories = YAML.load_file(File.join(__dir__,'../../../property/os/directory.yml'))
# p directories
# p directories['localhost']
# directories['localhost'].each do |dir|
#   dir.each do |hoge|
#     p hoge
#   end
# end

# p File.expand_path(File.dirname(__FILE__))
# p File.dirname(__FILE__)
# File.open(File.dirname(__FILE__)+'/../../../property/os/directory.json') do |file|
hash = Hash.new
File.open(File.expand_path('../../../property/os/directory.json', __FILE__)) do |file|
	hash = JSON.load(file)
end


p 'Hello, this is localhost sample spec rb'

# csv_directories=CSV.read(File.expand_path('../../../property/os/directory.csv', __FILE__), headers:true)
# csv_directories.each do |directory|
# 	unless directory["path"].nil?
# 		p directory["path"]
# 	end
# end

CSV.foreach(File.expand_path('../../../property/os/directory.csv', __FILE__), headers:true) do |row|
	unless row["path"].nil?
		# p row["path"]
		# p row["owner"]
	end
end



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

	# describe file('/Users/niiyama/infra_test') do
	#   it { should be_directory }
	#   it { should be_owned_by('niiyama') }
	#   it { should be_grouped_into('staff') }
	#   it { should be_mode '755' }
	# end

	# describe file('/Users/niiyama/Developer') do
	#   it { should be_directory }
	#   it { should be_owned_by('niiyama') }
	#   it { should be_grouped_into('staff') }
	#   it { should be_mode '755' }
	# end


# describe package('httpd'), :if => os[:family] == 'redhat' do
#   it { should be_installed }
# end

# describe package('apache2'), :if => os[:family] == 'ubuntu' do
#   it { should be_installed }
# end

# describe service('httpd'), :if => os[:family] == 'redhat' do
#   it { should be_enabled }
#   it { should be_running }
# end

# describe service('apache2'), :if => os[:family] == 'ubuntu' do
#   it { should be_enabled }
#   it { should be_running }
# end

# describe service('org.apache.httpd'), :if => os[:family] == 'darwin' do
#   it { should be_enabled }
#   it { should be_running }
# end

# describe port(80) do
#   it { should be_listening }
# end
