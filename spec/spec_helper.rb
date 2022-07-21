# frozen_string_literal: true

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = true
  config.default_formatter = "doc" if config.files_to_run.one?
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed

  config.define_derived_metadata(file_path: %r{/spec/capybara/}) do |metadata|
    metadata[:type] = :capybara
  end

  config.before(:suite) do
    require_relative "../sandbox"
    Capybara.app = Sandbox

    Capybara.register_driver :rack_test do |app|
      Capybara::RackTest::Driver.new(app, respect_data_method: true)
    end
  end

  require "capybara/rspec"
  config.include Capybara::DSL, type: :capybara
  config.include Capybara::RSpecMatchers, type: :capybara

  config.before(:each, type: :capybara) do
    Capybara.current_driver = :rack_test
  end
end
