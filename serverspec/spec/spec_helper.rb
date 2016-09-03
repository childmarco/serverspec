require 'serverspec'
require 'pathname'
require 'net/ssh'
require 'highline/import'
require 'pry'

set :backend, :ssh

host = ENV['TARGET_HOST']
options = Net::SSH::Config.for(host)

ENV['EXEC_TIME'] = Time.now.strftime("%Y%m%d_%H%M%S").to_s

options[:user] = ask("Enter login user:")
options[:password] = ask("Enter login password:")

if options[:password].empty? || options[:user].empty?
	# raise "Plase confirm the login user/password"
	p "Plase confirm the login user/password"
	exit();
else
	set :sudo_password, ask("Enter sudo password:")
	set :request_pty, true

	auth_ways = Array["password"]

	options[:port] = 22
	options[:auth_methods] = auth_ways

	set :host, host
	set :ssh_options, options

end
