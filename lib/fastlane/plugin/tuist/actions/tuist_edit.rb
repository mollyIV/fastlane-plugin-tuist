require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistEditAction < Action
      def self.run(params)
        command = ['edit']
        command.push('--path').push(params[:path]) if params[:path]

        command.push(params[:permanent] ? '--permanent' : '--no-permanent') unless params[:permanent].nil?

        command.push(params[:only_current_directory] ? '--only-current-directory' : '--no-only-current-directory') unless params[:only_current_directory].nil?

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Generates a temporary project to edit the project in the current directory"
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
            key: :path,
            description: "The path to the directory whose project will be edited (env: TUIST_EDIT_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :permanent,
            description: "It creates the project in the current directory or the one indicated by -p and doesn't block the process (env: TUIST_EDIT_PERMANENT)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :only_current_directory,
            description: "It only includes the manifest in the current directory (env: TUIST_EDIT_ONLY_CURRENT_DIRECTORY)",
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
