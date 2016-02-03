require 'spec_helper'

describe TenantsHelper::Tenants do
  let(:tenant_config_hash) {
    {
      1 => { 'name' => 'mock_tenant1', 'key' => 'abc123' },
      2 => { 'name' => 'mock_tenant2', 'key' => 'abc456' }
    }
  }
  let(:tenants) { TenantsHelper::Tenants.new }
  before do
    yaml_loader_double = double
    allow(Yamload::Loader).to receive(:new).and_return(yaml_loader_double)
    allow(yaml_loader_double).to receive(:content).and_return(tenant_config_hash)
  end

  context 'when initializing' do
    context 'without setting up config dir' do
      it 'should thrown an error' do
        expect { tenants }.to raise_error(NameError)
      end
    end

    context 'setting up with a config dir' do
      before do
        TenantsHelper.config_dir = '/tmp'
      end
      it 'should load successfully' do
        expect(tenants).to be_a(TenantsHelper::Tenants)
      end
    end
  end

  context 'when finding tenants' do
    before do
      TenantsHelper.config_dir = '/tmp'
    end

    context 'using find(id)' do
      let(:tenants_find_results) { tenants.find params }
      context 'with valid id' do
        let(:query_key) { 1 }
        let(:query_value) { tenant_config_hash[query_key] }
        let(:params) { query_key }
        it 'should find valid tenant' do
          expect(tenants_find_results).to be_a(TenantsHelper::Tenant)
          expect(tenants_find_results.id).to eq query_key
          expect(tenants_find_results.name).to eq query_value.fetch('name')
          expect(tenants_find_results.key).to eq query_value.fetch('key')
        end
      end

      context 'with invalid id' do
        let(:params) { 'invalid' }
        it 'should throw error' do
          expect { tenants_find_results }
            .to raise_error(ArgumentError, 'Could not find Tenant for {:id=>"invalid"}')
        end
      end
    end

    context 'using find_by' do
      let(:tenants_find_results) { tenants.find_by params }
      context 'with valid query' do
        let(:query_key) { 2 }
        let(:query_value) { tenant_config_hash[query_key] }
        let(:params) { { name: query_value.fetch('name') } }
        it 'should find result' do
          expect(tenants_find_results).to be_a(TenantsHelper::Tenant)
          expect(tenants_find_results.id).to eq query_key
          expect(tenants_find_results.name).to eq query_value.fetch('name')
          expect(tenants_find_results.key).to eq query_value.fetch('key')
        end
      end

      context 'with invalid query' do
        let(:params) { { name: 'invalid' } }
        it 'should not throw error' do
          expect { tenants_find_results }.not_to raise_error
        end
      end
    end

    context 'using find_by!' do
      let(:tenants_find_results) { tenants.find_by! params }
      context 'with valid query' do
        let(:query_key) { 2 }
        let(:query_value) { tenant_config_hash[query_key] }
        let(:params) { { name: query_value.fetch('name') } }
        it 'should find result' do
          expect(tenants_find_results).to be_a(TenantsHelper::Tenant)
          expect(tenants_find_results.id).to eq query_key
          expect(tenants_find_results.name).to eq query_value.fetch('name')
          expect(tenants_find_results.key).to eq query_value.fetch('key')
        end
      end

      context 'with invalid query' do
        let(:params) { { name: 'invalid' } }
        it 'should throw error' do
          expect { tenants_find_results }
            .to raise_error(ArgumentError, 'Could not find Tenant for {:name=>"invalid"}')
        end
      end
    end
  end

  context 'when calling valid?' do
    let(:tenants_valid_results) { tenants.valid? params }
    context 'with invalid id' do
      let(:params) { 'invalid' }
      it 'should return false' do
        expect(tenants_valid_results).to eq false
      end
    end

    context 'with valid id' do
      let(:params) { tenant_config_hash.keys[0] }
      it 'should return true' do
        expect(tenants_valid_results).to eq true
      end
    end
  end
end
