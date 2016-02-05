require 'spec_helper'

describe TenantsHelper do
  let(:tenant_config_hash) {
    {
      'tenant_one' => { 'name' => 'mock_tenant1', 'key' => 'abc123' },
      'tenant_two' => { 'name' => 'mock_tenant2', 'key' => 'abc456' }
    }
  }

  it 'has a version number' do
    expect(TenantsHelper::VERSION).not_to be nil
  end

  context 'when calling tenants' do
    let(:config_dir) { '/workspace/test_project' }
    let(:config_file) { 'test_config.yml' }
    let(:config_path) { config_dir + '/' + config_file }
    let(:tenants) { TenantsHelper.tenants config_path: config_path }
    before do
      yaml_loader_double = double
      allow(Yamload::Loader).to receive(:new).and_return(yaml_loader_double)
      allow(yaml_loader_double).to receive(:content).and_return(tenant_config_hash)
      allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)
    end
    it 'should load tenants successfully and return Tenants object' do
      expect(tenants).to be_a TenantsHelper::Tenants
    end
  end
end
