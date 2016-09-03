require 'rake'
require 'rspec/core/rake_task'
require 'yaml'

desc "Execute Rakefile"

properties = YAML.load_file(File.join(__dir__, 'property/properties.yml'))
# directory = YAML.load_file(File.join(__dir__,'../property/os/directory.yml'))


task :hello do
  puts 'hello'
  # puts properties

  # properties.map { |ips, tests| p ips }
  # properties.map { |ip, target_layer| p 'serverspec:' + ip }



@hostname = '192.168.56.150'
p @hostname

files = YAML.load_file(File.join(__dir__,'property/properties.yml'))
file = files[@hostname]["os"]["directory"]
p file
  # testscope = Array.new
  # properties.each do |ip, tests|
  #   puts "ip:#{ip}"
    # puts "tests:#{tests}"


    # puts "\n"


    # tests.each do |categories, types|
      # puts "categories:#{categories}"
      # puts "types#{types.keys}"

      # testscope = testscope.concat(types.keys)
      # testscope = testscope.( "orange"])
      # puts types[:mv][:apach]
      # puts "type:#{types.keys.join(",")}"
      #   puts "type:#{types.keys}"
      # puts types[:mv][:oracle]
      # puts types[:os][:directory]
      # types.each do |key, value|

        # p key
        # p value
      # end

      # types.each_key do |key|
      #   testscope << key
      #   p testscope
      # end

    # end


    # puts "\n"
    # puts "\n"
  # end
  # p testscope.join(",")


end

task :spec => 'spec:all'
# task :default => :spec

task :test => 'test:server'


namespace :test do
  task :server => :software
  properties.each do |hosts, target_layers|
    desc "Run serverspec to #{hosts}"
    test_file_pattern = Array.new
    RSpec::Core::RakeTask.new(hosts.to_sym) do |t|
      ENV['TARGET_HOST'] = hosts
			p hosts
			p target_layers
      target_layers.each do |test_layer, test_target|
        test_file_pattern = test_file_pattern.concat(test_target.keys)
      end
      t.pattern = "spec/*/{#{test_file_pattern.join(",")}}_spec.rb"
    end
  end

  task :software =>
         properties.map { |hosts, target_layers|
           target_layers.map { |target| "serverspec:#{hosts}:#{target}"
					 }
         }
  properties.each do |host, target_layer|
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


# namespace :serverspec do
#   task :all => properties.map { |host, testcases| 'serverspec:' + host }
#   properties.each do |host|
#     desc "Run serverspec to #{host[:name]}"
#     RSpec::Core::RakeTask.new(host[:short_name].to_sym) do |t|
#       ENV['TARGET_HOST'] = host[:name]
#       t.pattern          = 'spec/{' + host[:roles].join(',') + '}/*_spec.rb'
#     end
#   end
# end

# namespace :spec do
# 	targets = []
# 	Dir.glob('./spec/*').each do |dir|
# 		next unless File.directory?(dir)
# 		target = File.basename(dir)
# 		target = "_#{target}" if target == "default"
# 		targets << target
# 	end
#
# 	task :all => targets
# 	task :default => :all
#
# 	targets.each do |target|
# 		original_target = target == "_default" ? target[1..-1] : target
# 		desc "Run serverspec tests to #{original_target}"
# 		RSpec::Core::RakeTask.new(target.to_sym) do |t|
# 			ENV['TARGET_HOST'] = original_target
# 			t.pattern = "spec/#{original_target}/*_spec.rb"
# 		end
# 	end
# end

