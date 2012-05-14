#
# Cookbook Name:: app_php
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rightscale_marker :begin

log "  Setting provider specific settings for php application server."

node[:app][:provider] = "app_php"
node[:app][:destination]="#{node[:web_apache][:docroot]}"

case node[:platform]
when "ubuntu", "debian"
  if node[:app_php][:db_adapter] == "mysql"
    node[:app][:packages] = ["php5", "php5-mysql", "php-pear", "libapache2-mod-php5"]
  elsif node[:app_php][:db_adapter] == "postgresql"
    node[:app][:packages] = ["php5", "php5-pgsql", "php-pear", "libapache2-mod-php5"]
  else
    raise "Unrecognized database adapter #{node[:app][:db_adapter]}, exiting "
  end
when "centos","fedora","suse","redhat"
  if node[:app_php][:db_adapter] == "mysql"
    node[:app][:packages] = ["php53u", "php53u-mysql", "php53u-pear", "php53u-zts"]
  elsif node[:app_php][:db_adapter] == "postgresql"
    node[:app][:packages] = ["php53u", "php53u-pgsql", "php53u-pear", "php53u-zts"]
  else
    raise "Unrecognized database adapter #{node[:app_php][:db_adapter]}, exiting "
  end
else
  raise "Unrecognized distro #{node[:platform]}, exiting "
end

rightscale_marker :end
