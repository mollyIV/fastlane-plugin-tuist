require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistMigrationSettingsToXcconfigAction < Action
      def self.run(params)
        command = ['settings-to-xcconfig']
        command.push('--xcodeproj-path').push(params[:xcodeproj_path]) if params[:xcodeproj_path]

        command.push('--xcconfig-path').push(params[:xcconfig_path]) if params[:xcconfig_path]

        command.push('--target').push(params[:target]) if params[:target]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "It extracts the build settings from a project or a target into an xcconfig file"
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
            key: :xcodeproj_path,
            description: "The path to the Xcode project (env: TUIST_MIGRATION_SETTINGS_TO_XCCONFIG_XCODEPROJ_PATH)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :xcconfig_path,
            description: "The path to the xcconfig file where build settings will be extracted (env: TUIST_MIGRATION_SETTINGS_TO_XCCONFIG_XCCONFIG_PATH)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :target,
            description: "The name of the target whose build settings will be extracted When not passed, it extracts the build settings of the project (env: TUIST_MIGRATION_SETTINGS_TO_XCCONFIG_TARGET)",
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
