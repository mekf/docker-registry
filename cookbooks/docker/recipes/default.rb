#
# Cookbook Name:: docker
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

yum_package 'epel-release' do
  action :install
end

yum_package 'device-mapper' do
  action :upgrade
end

yum_package 'docker-io' do
  action :install
  notifies :run, 'bash[start_docker_service]'
end

bash 'start_docker_service' do
  code <<-CODE
    sudo service docker start
    sudo chkconfig docker on
  CODE
  action :nothing
  notifies :run, 'bash[pull_latest_registry_container]'
end

bash 'pull_latest_registry_container' do
  code <<-CODE
    sudo docker pull registry
  CODE
  action :nothing
end
