require 'memoist'

module TenantsHelper
  class ConfigLoader
    extend Memoist

    def initialize(config_path:)
      @config_path = config_path
      validate_config_path
    end

    def load_content
      Yamload::Loader.new(filename, dirname).content
    end
    memoize :load_content

    private

    def validate_config_path
      fail(Error, 'Invalid config path') if @config_path.blank? || !pathname.exist?
      fail(Error, 'Config file must be a yml') unless filename.extname == '.yml'
    end

    def pathname
      Pathname.new(@config_path)
    end
    memoize :pathname

    def dirname
      pathname.dirname
    end

    def filename
      pathname.basename
    end
  end
end
