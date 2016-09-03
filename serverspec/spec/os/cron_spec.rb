require 'spec_helper'
require 'yaml'
require 'pry'

crontabs = YAML.load_file(File.join(__dir__, '../../property/os/cron.yml'))['crontab']

describe "=======<OS> Crontab=======" do
  describe cron do
    crontabs.each do |execute_user, records|
      describe "<Crontab> #{execute_user}" do
        records.each do |record|
          # bnding.pry
          it { should have_entry(record).with_user(execute_user) }
        end
      end
    end
  end
end

