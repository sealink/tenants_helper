require 'spec_helper'

describe TenantsHelper do
  let(:tenant_config_hash) {
    {
      'tenant_one' => { 'name' => 'mock_tenant1' },
      'tenant_two' => { 'name' => 'mock_tenant2' }
    }
  }

  it 'has a version number' do
    expect(TenantsHelper::VERSION).not_to be nil
  end

  context 'when calling tenants' do
    let(:config_dir) { '/workspace/test_project' }
    let(:config_file) { 'test_config.yml' }
    let(:config_path) { config_dir + '/' + config_file }
    before do
      yaml_loader_double = double
      allow(Yamload::Loader).to receive(:new).and_return(yaml_loader_double)
      allow(yaml_loader_double).to receive(:content).and_return(tenant_config_hash)
      allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)
    end

    context 'setting the config_path in advance' do
      let(:default_filename) { 'tenants.yml' }
      let(:set_path) { TenantsHelper.set_path(config_dir: config_dir) }
      let(:tenants) { TenantsHelper.tenants }
      it 'should load tenants successfully and return Tenants object' do
        expect(set_path).to eq "#{config_dir}/#{default_filename}"
        expect(tenants).to be_a TenantsHelper::Tenants
      end
    end
    context 'passing the config_path explicitely to tenants method' do
      let(:tenants) { TenantsHelper.tenants config_path: config_path }
      it 'should load tenants successfully and return Tenants object' do
        expect(tenants).to be_a TenantsHelper::Tenants
      end
    end
  end
end
