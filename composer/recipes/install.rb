node[:deploy].each do |application, deploy|
  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    curl -s https://getcomposer.org/installer | php
    php composer.phar install --no-dev --no-interaction --prefer-dist
    EOH
    only_if { ::File.exist?("#{deploy[:deploy_to]}/current/composer.json")}
  end
end