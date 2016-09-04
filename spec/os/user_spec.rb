require 'spec_helper'
require 'yaml'
require 'json'
require 'csv'

require_relative '../../helpers/directory_helper'
include DirectoryHelper

describe user('apache') do
  it { should belong_to_group 'apache' }
end

describe user('apache') do
  it { should belong_to_primary_group 'apache' }
end

