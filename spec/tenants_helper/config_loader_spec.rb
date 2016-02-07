require 'spec_helper'

describe TenantsHelper::ConfigLoader do
  let(:tenant_config_hash) {
    {
      'tenant_one' => { 'name' => 'mock_tenant1', 'key' => 'abc123' },
      'tenant_two' => { 'name' => 'mock_tenant2', 'key' => 'abc456' }
    }
  }
  let(:config_dir) { '/workspace/test_project' }
  let(:config_file) { 'test_config.yml' }
  let(:config_path) { config_dir + '/' + config_file }
  let(:tenants_hash_loader) { TenantsHelper::ConfigLoader.new config_path: config_path }

  context 'when loding config' do
    context 'with a valid path and config' do
      before do
        yaml_loader_double = double
        allow(Yamload::Loader).to receive(:new).and_return(yaml_loader_double)
        allow(yaml_loader_double).to receive(:content).and_return(tenant_config_hash)
        allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)
      end
      it 'should load tenants hash correctly' do
        expect(tenants_hash_loader.load_content).to eq tenant_config_hash
      end
    end

    context 'loading with missing dir and filename' do
      let(:config_path) { nil }
      it 'should raise an error' do
        expect { tenants_hash_loader.load_content }.to raise_error(
          TenantsHelper::Error,
          'Invalid config path'
        )
      end
    end

    context 'loading with missing filename' do
      let(:config_file) { '' }
      before do
        allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)
      end
      it 'should raise an error' do
        expect { tenants_hash_loader.load_content }.to raise_error(
          TenantsHelper::Error,
          'Config file must be a yml'
        )
      end
    end
  end
end
