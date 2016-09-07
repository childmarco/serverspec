class PreviousHelper

  def initialize
    @testing_hostname_condition = YAML.load_file(File.join(__dir__, '../property/properties.yml'))
    @spec_file_path             = caller[0][/^([^:]+):\d+:in `[^']*'$/, 1]

  end


  def get_csv_config(hostname)
    target_layer = @spec_file_path.split("/")[-2]
    spec_file    = File.basename(@spec_file_path).match(/(^.+?)_spec.rb/)[1]
    config_file  = @testing_hostname_condition[hostname][target_layer][spec_file]

    csv_config_file = CSV.read(File.expand_path("../../property/#{target_layer}/#{config_file}", __FILE__), headers: true, skip_blanks: true)
    return csv_config_file
  end


  def get_yaml_config(hostname)
    target_layer = @spec_file_path.split("/")[-2]
    spec_file    = File.basename(@spec_file_path).match(/(^.+?)_spec.rb/)[1]
    config_file  = @testing_hostname_condition[hostname][target_layer][spec_file]

    yaml_config_file = YAML.load_file(File.join(__dir__, "../../property/#{target_layer}/#{config_file}"))
    return yaml_config_file
  end

  def get_json_config(hostname)
    target_layer = @spec_file_path.split("/")[-2]
    spec_file    = File.basename(@spec_file_path).match(/(^.+?)_spec.rb/)[1]
    config_file  = @testing_hostname_condition[hostname][target_layer][spec_file]

    json_config_file = Hash.new
    File.open(File.expand_path("../../property/#{target_layer}/#{config_file}", __FILE__)) do |io|
      json_config_file = JSON.load(io)
    end

    return json_config_file
  end

end
