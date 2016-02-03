module TenantsHelper
  class Tenants
    def initialize
      Yamload.dir = TenantsHelper.config_dir
      @tenants_hash = Yamload::Loader.new(TenantsHelper.config_filename).content
      @tenants ||= TenantsHelper::QueryableCollection.new(
        @tenants_hash.map { |id, attributes|
          new_attributes = symbolize_keys(attributes)
          Tenant.new(new_attributes.merge(id: id))
        },
        Tenant.anima.attribute_names
      )
    end

    def find_by(query)
      @tenants.find_by(query)
    end

    def find_by!(query)
      find_by(query) ||
        fail(ArgumentError,
             "Could not find Tenant for #{query.inspect}")
    end

    def find(id)
      find_by!(id: id)
    end

    def valid?(id)
      result = find_by(id: id)
      !result.blank?
    end

    private

    def symbolize_keys(hash_to_process)
      return_hash = {}
      hash_to_process.each do |key, value|
        new_key = key.is_a?(String) ? key.to_sym : key
        return_hash[new_key] = value
      end
      return_hash
    end
  end

  class Tenant
    include Anima.new(:id, :name, :key)
  end
end
