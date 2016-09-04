require 'rake'
require 'rspec/core/rake_task'
require 'yaml'

@properties = YAML.load_file(File.join(__dir__, 'property/properties.yml'))

task :hello do
  puts 'hello serverspec world'

  @hostname = '192.168.56.150'
  p @hostname

  files = YAML.load_file(File.join(__dir__, 'property/properties.yml'))
  file  = files[@hostname]["os"]["directory"]
  p file

end

task :spec => 'spec:all'
task :test => 'test:server'

namespace :test do
  task :server => :software
  @properties.each do |hosts, target_layers|
    desc "Run serverspec to #{hosts}"
    test_file_pattern = Array.new
    RSpec::Core::RakeTask.new(hosts.to_sym) do |t|
      ENV['TARGET_HOST'] = hosts
      target_layers.each do |test_layer, test_target|
        test_file_pattern = test_file_pattern.concat(test_target.keys)
      end
      t.pattern = "spec/*/{#{test_file_pattern.join(",")}}_spec.rb"
    end
  end

  task :software =>
         @properties.map { |hosts, target_layers|
           target_layers.map { |target| "serverspec:#{hosts}:#{target}"
           }
         }
  @properties.each do |host, target_layer|
    target_layer.each do |categories, types|
      types.each do |key, value|
        desc "Run serverspec to #{key} in #{host}"
        RSpec::Core::RakeTask.new("#{host.to_sym}:#{key.to_sym}") do |t|
          ENV['TARGET_HOST'] = host
          t.pattern          = "spec/*/#{key}_spec.rb"
        end
      end
    end
  end
end

