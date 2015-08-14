node[:deploy].each do |application, deploy|
  interpreter "bash"
  user "root"
  cwd "#{deploy[:deploy_to]}/current"
  code <<-EOH
  chdmod -R 777 storage
  EOH
end