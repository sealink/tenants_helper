require 'spec_helper'

describe TenantsHelper do
  it 'has a version number' do
    expect(TenantsHelper::VERSION).not_to be nil
  end

  context 'setting config dir and filename' do
    let(:config_dir) { '/tmp' }
    let(:default_config_filename) { :tenants }
    let(:different_config_filename) { :custom_config }

    it 'should set config dir' do
      TenantsHelper.config_dir = config_dir
      expect(TenantsHelper.config_dir).to eq config_dir
    end

    it 'should have default config filename' do
      expect(TenantsHelper.config_filename).to eq default_config_filename
    end

    it 'should set config filename' do
      TenantsHelper.config_filename = different_config_filename
      expect(TenantsHelper.config_filename).to eq different_config_filename
    end
  end
end
