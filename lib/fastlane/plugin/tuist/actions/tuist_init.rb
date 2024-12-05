require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistInitAction < Action
      def self.run(params)
        command = ['init']
        command.push('--platform').push(params[:platform]) if params[:platform]

        command.push('--name').push(params[:name]) if params[:name]

        command.push('--template').push(params[:template]) if params[:template]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Bootstraps a project"
      end

      def self.authors
        ["tuist"]
      end

      def self.return_value
        nil
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :platform,
            description: "The platform (iOS, tvOS, visionOS, watchOS or macOS) the product will be for (Default: iOS) (env: TUIST_INIT_PLATFORM)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :name,
            description: "The name of the project (Default: Name of the current directory) (env: TUIST_INIT_NAME)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :template,
            description: "The name of the template to use (you can list available templates with tuist scaffold list) (env: TUIST_INIT_TEMPLATE)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the folder where the project will be generated (Default: Current directory) (env: TUIST_INIT_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :help,
            description: "Show help information",
            optional: true,
            type: Boolean
          )

        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
