require 'spec_helper'
set :backend, :exec

describe host('uhostserver.getuhost.org') do
  it { should be_resolvable.by('hosts') }
end

describe host('chef.uhostserver.getuhost.org') do
  it { should be_resolvable.by('hosts') }
end
