require 'spec_helper'

describe package('elasticsearch') do
  it { should be_installed }
end

describe file('/etc/default/elasticsearch') do
  its(:content) { should match 'ES_MIN_MEM=512m' }
  its(:content) { should match 'ES_MAX_MEM=1g' }
end

describe file('/etc/elasticsearch/elasticsearch.yml') do
  its(:content) { should match 'network.publish_host: localhost' }
  its(:content) { should match 'cluster.name: foo' }
end

describe command('pgrep java | wc -l') do
  its(:stdout) { should match /^1$/ }
end
