require 'spec_helper'
require 'yaml'
require 'json'
require 'csv'

require_relative '../../helpers/directory_helper'
include DirectoryHelper

@hostname = ENV['TARGET_HOST']
p @hostname

files = YAML.load_file(File.join(__dir__,'../../property/properties.yml'))
file = files[@hostname]["os"]["directory"]

p file
# p File.expand_path(File.dirname(__FILE__))
# p File.dirname(__FILE__)
# File.open(File.dirname(__FILE__)+'/../../../property/os/directory.json') do |file|
hash = Hash.new
File.open(File.expand_path('../../../property/os/directory.json', __FILE__)) do |file|
  hash = JSON.load(file)
end

# csv_directories=CSV.read(File.expand_path('../../../property/os/directory.csv', __FILE__), headers:true)
# csv_directories.each do |directory|
# 	unless directory["path"].nil?
# 		p directory["path"]
# 	end
# end

describe "Check Directory" do
  CSV.foreach(File.expand_path('../../../property/os/directory.csv', __FILE__), headers: true, skip_blanks: true) do |row|
    unless row["path"].nil?
      describe file(row["path"]) do
        it { should be_directory }
        it { should be_owned_by(row["owner"]) }
        it { should be_grouped_into(row["group"]) }
        it { should be_mode row["permission"] }
      end

    end
  end
end
