require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistProjectShowAction < Action
      def self.run(params)
        command = ['show']
        command.push(params[:full_handle]) if params[:full_handle]

        command.push('--path').push(params[:path]) if params[:path]

        command.push(params[:web] ? '--web' : '--no-web') unless params[:web].nil?

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Show information about the specified project Use --web flag to open the project in the browser"
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
            key: :full_handle,
            description: "The project to show The full handle must be in the format of account-handle/project-handle (env: TUIST_PROJECT_SHOW_FULL_HANDLE)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the Tuist project (env: TUIST_PROJECT_SHOW_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :web,
            description: "Open a project in the browser (env: TUIST_PROJECT_SHOW_WEB)",
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
