default[:dev_sandbox][:user]  = "vagrant"
default[:dev_sandbox][:group] = "vagrant"

# ubuntu14.04には1系インストール不可
# 2系はデフォルトのインストールパスが/optに変更される
default[:td_agent][:version] = 2

default[:ruby][:versions] = ["2.0.0-p598"]
