require 'spec_helper'

describe package('td-agent') do
  it { should be_installed }
end

describe service('td-agent') do
  it { should be_running }
end

describe port(24224) do
  it "listening tcp" do should be_listening.with('tcp') end
  it "listening udp" do should be_listening.with('udp') end
end
