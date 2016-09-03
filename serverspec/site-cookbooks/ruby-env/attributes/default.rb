#
# Cookbook Name:: ruby-env
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

default['ruby-env']['user']           = "vagrant"
default['ruby-env']['group']          = "vagrant"
default['ruby-env']['version']        = "2.3.0"
default["ruby-env"]["rbenv_url"]      = "https://github.com/sstephenson/rbenv"
default["ruby-env"]["ruby-build_url"] = "https://github.com/sstephenson/ruby-build"
default["ruby-env"]["yum-pkg"]        = ["gcc",
                                         "git",
                                         "vim",
                                         "openssl-devel",
                                         "sqlite-devel",
                                         "gcc-c++",
                                         "openssl-devel",
                                         "readline-devel",
                                         "zlib-devel",
                                         "libcurl-devel",
                                         "libffi-devel",
                                         "readline",
                                         "readline-devel"]
