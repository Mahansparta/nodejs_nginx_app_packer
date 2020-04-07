#
# Cookbook:: nodejs_nginx
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'nodejs_nginx::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    #let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'runs apt get update ' do
      expect(chef_run).to update_apt_update 'update_sources'
    end

    #Installing nginx
    it 'should install nginx' do
      expect(chef_run).to install_package 'nginx'
    end

    # install nodejs
    # get this to be installed from a dependency
    it 'should install nodejs' do
      expect(chef_run).to install_package 'nodejs'
    end

    #Services
    #nginx
    it 'should enables nginx' do
      expect(chef_run).to enable_service 'nginx'
    end

    it 'should start nginx' do
      expect(chef_run).to start_service 'nginx'
    end

    it 'should install pm2 via npm' do
      expect(chef_run).to include_recipe 'nodejs'
    end

    it 'should install pm2 via npm' do
      expect(chef_run).to install_npm_package 'pm2'
    end

    it 'should install pm2 via npm' do
      expect(chef_run).to install_npm_package 'react'
    end

    # if we created a new proxy.config file for nginx
    it 'should crea a proxy.conf template in /etc/nginx/sites-available' do
      expect(chef_run).to create_template("/etc/nginx/sites-available/proxy.conf").with_variables(proxy_port: 3000)
    end

    it 'it should create a symlink of proxy.conf from site-available to site-enabled' do
      expect(chef_run).to create_link("/etc/nginx/sites-enabled/proxy.conf").with_link_type(:symbolic)
    end

    it 'should delete the symlink from the default config in site-enabled' do
      expect(chef_run).to delete_link "/etc/nginx/sites-enabled/default"
    end

  end
end
