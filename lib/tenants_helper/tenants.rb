require 'facets/hash/rekey'
module TenantsHelper
  class Tenants
    def initialize(tenants_config_hash:)
      @tenants = QueryableCollection.create(
        tenants_config_hash.map { |id, attributes|
          new_attributes = attributes.rekey
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
      !find_by(id: id).nil?
    end
  end

  class Tenant
    include Anima.new(:id, :name)
  end
end
