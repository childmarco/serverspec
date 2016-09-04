require 'csv'
require 'yaml'
require 'json'

module CommonHelper

  @@testing_hostname_condition = YAML.load_file(File.join(__dir__, '../property/properties.yml'))

  def get_csv_config(hostname, layer, target)

    spec_file_path = caller[0][/^([^:]+):\d+:in `[^']*'$/, 1]
    # spec_file      = File.basename(__FILE__).match(/(^.+?)_spec.rb/)
    spec_file      = File.basename(spec_file_path).match(/(^.+?)_spec.rb/)[1]
    target_layer   = spec_file_path.split("/")[-2]

    p spec_file[1]
    p target_layer[-2]


    config_file = @@testing_hostname_condition[hostname][layer][target]


    # csv = CSV.read(File.expand_path('../../property/properties.yml', __FILE__), header: true, skip_blanks: true)

  end


  def get_yml_config()


  end

  def get_json_config()

  end


end





