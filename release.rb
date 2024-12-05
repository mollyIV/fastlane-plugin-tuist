require 'json'
require 'fileutils'

# Fetch the Tuist CLI API
tuist_output = `tuist --experimental-dump-help`
data = JSON.parse(tuist_output)

# Function to generate the implementation
# @param [Hash] command The command data from the JSON
# @param [String] prefix The prefix for the command name
def generate_implementation(command, prefix)
  puts "Generating implementation for #{command['commandName']}"

  file_name = "#{prefix}#{command['commandName'].tr('-', '_')}"
  class_name = "#{camel_case(file_name)}Action"
  file_path = "lib/fastlane/plugin/tuist/actions/#{file_name}.rb"

  # Create the directory if it doesn't exist
  FileUtils.mkdir_p(File.dirname(file_path))

  # Generate the implementation
  implementation = <<-RUBY
require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
module Actions
class #{class_name} < Action

#{generate_run_method(command)}
#{generate_description(command)}
def self.authors
["tuist"]
end

def self.return_value
nil
end

#{generate_available_options(command)}
def self.is_supported?(platform)
true
end

end
end
end
  RUBY

  # Write the implementation to the file
  File.write(file_path, implementation)

  # Run RuboCop to format the file
  system("rubocop -a #{file_path} > /dev/null 2>&1")
end

# Function to generate the run method
# @param [Hash] command The command data from the JSON
# @return [String] The generated run method
def generate_run_method(command)
  sorted_arguments = sort_arguments(command['arguments'])
  argument_handling = sorted_arguments.map do |arg|
    key = arg['valueName'].tr('-', '_')

    case arg['kind']
    when 'option'
      <<-RUBY
command.push('--#{arg['valueName']}').push(params[:#{key}]) if params[:#{key}]
      RUBY
    when 'positional'
      <<-RUBY
command.push(params[:#{key}]) if params[:#{key}]
      RUBY
    when 'flag'
      if arg['names'].any? { |name| name['name'].start_with?('no-') }
        <<-RUBY
command.push(params[:#{key}] ? '--#{arg['valueName']}' : '--no-#{arg['valueName']}') unless params[:#{key}].nil?
        RUBY
      else
        <<-RUBY
command.push('--#{arg['valueName']}') if params[:#{key}]
        RUBY
      end
    end
  end.join("\n")

  <<-RUBY
def self.run(params)
command = ['#{command['commandName']}']
#{argument_handling}
Helper::TuistHelper.call_tuist_cli(command)
end
  RUBY
end

# Function to generate the description method
# @param [Hash] command The command data from the JSON
# @return [String] The generated description method
def generate_description(command)
  description = command['abstract'].gsub('.', '')
  <<-RUBY
def self.description
"#{description}"
end
  RUBY
end

# Function to generate the available_options method
# @param [Hash] command The command data from the JSON
# @return [String] The generated available_options method
def generate_available_options(command)
  sorted_arguments = sort_arguments(command['arguments'])
  options = sorted_arguments.map do |arg|
    key = arg['valueName'].tr('-', '_')
    description = arg['abstract'].gsub('.', '')
    type = arg['kind'] == 'flag' ? 'Boolean' : 'String'
    <<-RUBY
      FastlaneCore::ConfigItem.new(
        key: :#{key},
        description: "#{description}",
        optional: #{arg['isOptional']},
        type: #{type}
      ),
    RUBY
  end.join("\n")

  <<-RUBY
  def self.available_options
    [
      #{options}
    ]
  end
  RUBY
end

# Function to sort arguments by kind
# @param [Array<Hash>] arguments The list of arguments
# @return [Array<Hash>] The sorted list of arguments
def sort_arguments(arguments)
  kind_order = { 'positional' => 0, 'option' => 1, 'flag' => 2 }
  arguments.sort_by { |arg| kind_order[arg['kind']] }
end

# Function to convert command name to CamelCase
# @param [String] str The string to convert
# @return [String] The CamelCase version of the string
def camel_case(str)
  str.split('_').map(&:capitalize).join
end

# Function to recursively process commands and subcommands
# @param [Hash] command The command data from the JSON
# @param [String] prefix The prefix for the command name
def process_commands(command, prefix)
  # Check if the command has subcommands
  if command['subcommands'] && !command['subcommands'].empty?
    # Iterate over the subcommands and call the function recursively
    command['subcommands'].each do |subcommand|
      process_commands(subcommand, "#{prefix}#{command['commandName']}_")
    end
  else
    # Generate the implementation for the current command if it has no subcommands
    generate_implementation(command, prefix)
  end
end

# Get the top-level command
top_command = data['command']

# Start the recursive printing with the top-level command
process_commands(top_command, '')