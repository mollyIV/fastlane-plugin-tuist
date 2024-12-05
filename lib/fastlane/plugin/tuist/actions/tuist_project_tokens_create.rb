require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistProjectTokensCreateAction < Action
      def self.run(params)
        command = ['create']
        command.push(params[:full_handle]) if params[:full_handle]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Create a new Tuist project token You can save this token in the `TUIST_CONFIG_TOKEN` environment variable to authenticate requests against the Tuist API"
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
            description: "The project to create the token for Must be in the format of account-handle/project-handle (env: TUIST_PROJECT_TOKEN_FULL_HANDLE)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory or a subdirectory of the project (env: TUIST_PROJECT_TOKEN_PATH)",
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
