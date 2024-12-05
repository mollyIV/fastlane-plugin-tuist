require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistShareAction < Action
      def self.run(params)
        command = ['share']
        command.push(params[:apps]) if params[:apps]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--configuration').push(params[:configuration]) if params[:configuration]

        command.push('--platforms').push(params[:platforms]) if params[:platforms]

        command.push('--derived-data-path').push(params[:derived_data_path]) if params[:derived_data_path]

        command.push(params[:json] ? '--json' : '--no-json') unless params[:json].nil?

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Generate a link to share your app"
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
            key: :apps,
            description: "The app name to be looked up in the built products directory or the paths to the app bundles or an ipa archive (env: TUIST_SHARE_APP)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory that contains a Tuist or Xcode project with a buildable scheme that can output runnable artifacts",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :configuration,
            description: "The configuration of the app to share Ignored when the app paths are passed directly (env: TUIST_SHARE_CONFIGURATION)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :platforms,
            description: "The platforms (iOS, tvOS, visionOS, watchOS or macOS) to share the app for Ignored when the app paths are passed directly (env: TUIST_SHARE_PLATFORM)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :derived_data_path,
            description: "The derived data path to find the apps in When absent, the system-configured one (env: TUIST_SHARE_DERIVED_DATA_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :json,
            description: "The output in JSON format (env: TUIST_SHARE_JSON)",
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
