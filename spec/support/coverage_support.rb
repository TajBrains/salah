require 'simplecov'
require 'simplecov-lcov'

# this configuration is needed for vs code plugin to work correctly
SimpleCov::Formatter::LcovFormatter.config do |c|
	c.report_with_single_file = true
	c.output_directory = 'coverage'
	c.lcov_file_name = 'lcov.info'
end

# Most plugins for vs code working with lcov.info file, therefore we dont use the html formatter
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter

SimpleCov.start do
	enable_coverage :branch
	formatter SimpleCov::Formatter::MultiFormatter.new([
																											 SimpleCov::Formatter::LcovFormatter, # Add Lcov as an output when generating code coverage report
																											 SimpleCov::Formatter::HTMLFormatter # Add other outputs for the code coverage report
																										 ])
	add_filter "/spec/"
	add_filter "/config/"
end
