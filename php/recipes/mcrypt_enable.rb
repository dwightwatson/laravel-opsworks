case node[:platform]
when "debian", "ubuntu"
  execute "enable_mcrypt" do
    user "root"
    command "php5enmod mcrypt && service apache2 restart"
    only_if { ::File.exist?("/etc/php5/mods-available/mcrypt.ini") }
  end
end