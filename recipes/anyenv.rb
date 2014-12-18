user  = node[:dev_sandbox][:user]
group = node[:dev_sandbox][:group] 

bash "install_anyenv" do
  user  user
  group group
  code <<-EOC
  git clone https://github.com/riywo/anyenv ~/.anyenv
  echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.shenv_local
  echo 'eval "$(anyenv init -)"' >> ~/.shenv_local
  exec $SHELL -l
  EOC
  not_if "test -d ~/.anyenv", :environment => {"HOME" => "/home/#{user}"} 
end
