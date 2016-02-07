module TenantsHelper
  class << self
    def tenants(config_path:)
      config_loader = TenantsHelper::ConfigLoader.new(config_path: config_path)
      config_content = config_loader.load_content
      TenantsHelper::Tenants.new(tenants_config_hash: config_content)
    end
  end

  Error = Class.new(StandardError)
end

require 'yamload'
require 'queryable_collection'
require 'tenants_helper/version'
require 'tenants_helper/config_loader'
require 'tenants_helper/tenants'
