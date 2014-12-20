include_recipe "dev_sandbox::anyenv"

user  = node[:dev_sandbox][:user]
group = node[:dev_sandbox][:group] 

# TODO **env系でまとめる
bash "install_deb_ruby" do
  code "aptitude build-dep ruby -y"
end

bash "install_rbenv" do
  user  user
  group group
  code <<-EOC
  source ~/.shenv_local
  anyenv install rbenv
  EOC
  not_if "test -d ~/.anyenv/envs/rbenv", :environment => {"HOME" => "/home/#{user}"} 
end

vers = node[:ruby][:versions]
vers.each do |v|

  bash "install_ruby_#{v}" do
    user  user
    group group
    code <<-EOC
      source ~/.shenv_local
      rbenv install #{v}
    EOC
    not_if "test -d ~/.anyenv/envs/rbenv/versions/#{v}", :environment => {"HOME" => "/home/#{user}"} 
  end

  %w[
    bundler
    pry
  ].each do |g|
    bash "install_ruby_#{v}_#{g}" do
      user  user
      group group
      cwd "/home/#{user}"
      code <<-EOC
        source ~/.shenv_local
        rbenv local #{v}
        rbenv rehash
        gem install #{g} --no-ri --no-rdoc
      EOC
    end
  end

end
