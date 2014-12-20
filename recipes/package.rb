# install packages for development

%w[
  nano
].each do |app|
  package app do
    action :purge
  end
end

%w[
  build-essential
  zsh
  vim
  git
  tig
  tmux
  ack-grep
  trash-cli
  htop
  redis-server
  libsqlite3-dev
  libmysqlclient-dev
].each do |app|
  package app do
    action :upgrade
  end
end

user  = node[:dev_sandbox][:user]
bash "chsh_zsh" do
  code <<-EOC
      chsh -s /bin/zsh #{user}
  EOC
  not_if 'test "/bin/zsh" = "$(grep #{user} /etc/passwd | cut -d: -f7)"'
end

# TODO dotfilesをcloneする
