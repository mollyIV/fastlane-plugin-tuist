require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistGenerateAction < Action
      def self.run(params)
        path = params[:path]
        binary_cache = params[:binary_cache]
        configuration = params[:configuration]

        command = ["generate"]
        command.push('--path').push(path)
        command.push('--no-open')
        command.push('--no-binary-cache') if binary_cache
        command.push('--configuration').push(configuration) if configuration

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Generates an Xcode workspace to start working on the project."
      end

      def self.authors
        ["mollyIV"]
      end

      def self.return_value
        nil
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :path,
            env_name: "TUIST_GENERATE_PATH",
            description: "The path to the directory or a subdirectory of the project",
            optional: false,
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :binary_cache,
            env_name: "TUIST_GENERATE_BINARY_CACHE",
            description: "Ignore binary cache and use sources only",
            optional: true,
            default_value: false,
            type: Boolean
          ),
          FastlaneCore::ConfigItem.new(
            key: :configuration,
            env_name: "TUIST_GENERATE_BINARY_CACHE",
            description: "Configuration to generate for",
            optional: true,
            type: String
          )
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
