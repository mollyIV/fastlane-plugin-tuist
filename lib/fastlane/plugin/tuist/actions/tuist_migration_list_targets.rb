require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistMigrationListTargetsAction < Action
      def self.run(params)
        command = ['list-targets']
        command.push('--xcodeproj-path').push(params[:xcodeproj_path]) if params[:xcodeproj_path]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "It lists the targets of a project sorted by number of dependencies"
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
            description: "The path to the Xcode project (env: TUIST_MIGRATION_LIST_TARGETS_XCODEPROJ_PATH)",
            optional: false,
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
