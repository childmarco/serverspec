require_relative '../spec_helper'
require_relative '../../helpers/previous_helper'
require 'yaml'
require 'json'
require 'csv'

get_config_file = PreviousHelper.new
csv_config_file = get_config_file.get_csv_config(ENV['TARGET_HOST'])

describe "Check Directory" do
  csv_config_file.each do |row|
    describe file(row["path"]) do
      it { should be_directory }
      it { should be_owned_by(row["owner"]) }
      it { should be_grouped_into(row["group"]) }
      it { should be_mode row["permission"] }
    end
  end
end