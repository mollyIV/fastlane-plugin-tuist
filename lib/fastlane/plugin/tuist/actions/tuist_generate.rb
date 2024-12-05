require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistGenerateAction < Action
      def self.run(params)
        command = ['generate']
        command.push(params[:sources]) if params[:sources]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--configuration').push(params[:configuration]) if params[:configuration]

        command.push(params[:open] ? '--open' : '--no-open') unless params[:open].nil?

        command.push(params[:binary_cache] ? '--binary-cache' : '--no-binary-cache') unless params[:binary_cache].nil?

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Generates an Xcode workspace to start working on the project"
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
            key: :sources,
            description: "A list of targets to focus on Other targets will be linked as binaries if possible If no target is specified, all the project targets will be generated (except external ones, such as Swift packages)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory or a subdirectory of the project (env: TUIST_GENERATE_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :configuration,
            description: "Configuration to generate for",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :open,
            description: "Don't open the project after generating it (env: TUIST_GENERATE_OPEN)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :binary_cache,
            description: "Ignore binary cache and use sources only (env: TUIST_GENERATE_BINARY_CACHE)",
            optional: true,
            type: Boolean
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
