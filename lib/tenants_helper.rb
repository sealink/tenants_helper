require 'tenants_helper/version'

module TenantsHelper
  class << self
    attr_accessor :config_dir
    attr_accessor :config_filename

    def config_dir
      return @config_dir unless @config_dir.nil?
      return Rails.root.join('config') if Rails.root.join('config')
      nil
    end

    def config_filename
      @config_filename ||= :tenants
    end
  end
end

require 'yamload'
require 'tenants_helper/tenants'
require 'tenants_helper/queryable_collection'
