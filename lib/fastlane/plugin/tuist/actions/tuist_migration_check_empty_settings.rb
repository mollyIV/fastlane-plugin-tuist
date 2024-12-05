require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistMigrationCheckEmptySettingsAction < Action
      def self.run(params)
        command = ['check-empty-settings']
        command.push('--xcodeproj-path').push(params[:xcodeproj_path]) if params[:xcodeproj_path]

        command.push('--target').push(params[:target]) if params[:target]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "It checks if the build settings of a project or target are empty Otherwise it exits unsuccessfully"
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
            description: "The path to the Xcode project (env: TUIST_MIGRATION_CHECK_EMPTY_SETTINGS_XCODEPROJ_PATH)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :target,
            description: "The name of the target whose build settings will be checked When not passed, it checks the build settings of the project (env: TUIST_MIGRATION_CHECK_EMPTY_SETTINGS_TARGET)",
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
