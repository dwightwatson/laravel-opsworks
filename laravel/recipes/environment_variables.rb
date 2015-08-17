node[:deploy].each do |application, deploy|
  template "#{deploy[:deploy_to]}/current/.env" do
    source ".env.erb"
    mode 0755
    owner deploy[:user]
    group deploy[:group]

    variables(
      database: deploy[:database],
      variables: (deploy[:environment_variables] rescue {}),
    )

    only_if { ::File.directory?("#{deploy[:deploy_to]}/current") }
  end
end