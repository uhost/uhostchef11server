require 'spec_helper'

describe 'uhostchef11server::api' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
   
  before do
    stub_command("which nginx").and_return('/usr/sbin/nginx')
  end

  it 'installs nodejs' do
    expect(chef_run).to install_package('nodejs')
  end
end
