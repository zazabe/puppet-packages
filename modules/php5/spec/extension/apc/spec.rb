require 'spec_helper'

describe 'php5::extension::apc' do

  describe command('php --ri apc') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/php/error.log') do
    its(:content) { should_not match /Warning.*apc.*already loaded/ }
  end

  describe command('php --ri apc') do
    its(:stdout) { should match /apc.cache_by_default => Off/ }
  end
end
