require 'csv'
require 'yaml'
require 'json'

module PreviousHelper


  @@testing_hostname_condition = YAML.load_file(File.join(__dir__, '../property/properties.yml'))

  def get_csv_config(hostname)
    spec_file_path  = caller[0][/^([^:]+):\d+:in `[^']*'$/, 1]
    target_layer    = spec_file_path.split("/")[-2]
    spec_file       = File.basename(spec_file_path).match(/(^.+?)_spec.rb/)[1]
    config_file     = @@testing_hostname_condition[hostname][target_layer][spec_file]
    csv_config_file = CSV.read(File.expand_path("../../property/#{target_layer}/#{config_file}", __FILE__), headers: true, skip_blanks: true)

    return csv_config_file
  end


  def get_yaml_config()


  end

  def get_json_config()

  end


end

