# TenantsHelper

TenantsHelper is a gem designed to help you load and query a tenants configuration file.
A tenants configuration is a very specific YML config file in your project that is in the following format:

```yml
test_tenant_1:
  name: Test Tenant 1
test_tenant_2:
  name: Test Tenant 2
```

In its current format, the configuration is fairly simple. At the top level is a tenant_id and then under that are the tenant properties.
The required tenant properties will be updated over time as more distinct requirements for tenants are introduced.
Semantic versioning will be used to ensure new requirements do not break existing projects.
(Thus it is important for you to version lock the Gem in your project)

TenantHelper helps you to achieve the following:
 * Ensures all your projects that require tenants/clients meet the minimum required properties
 * Provides a centralised interface to query the tenants

## Installation

Add this line to your application's Gemfile

```ruby
gem 'tenants_helper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tenants_helper

## Usage

Ensure you have a tenants.yml config file within your project. The file must comply with the sample shown above.
Now call TenantsHelper with the path to the config file explicitly passed in

```ruby
tenants = TenantsHelper.tenants config_path: config_path
```

This will return a TenantsHelper::Tenants object which can then be used to query the tenants config.

```ruby
tenants.valid? test_tenant_1 # Checks to see if 'test_tenant_1' is a valid tenant id
tenant = tenants.find test_tenant_1 # Returns the tenant object corresponding with the passed in id
puts "Tenant name: #{tenant.name}" # The tenant object can then be used to determine the tenant properties
tenants.find_by(name: 'Test Tenant 2') # Returns the first tenant object that meets the query requirements
tenants.find_by!(name: 'Test Tenant 2') # Same as above, but gets angry if no tenant is found
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/sealink/tenants_helper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Reques
