require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistProjectTokensRevokeAction < Action
      def self.run(params)
        command = ['revoke']
        command.push(params[:project_token_id]) if params[:project_token_id]

        command.push(params[:full_handle]) if params[:full_handle]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Revoke Tuist project tokens"
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
            key: :project_token_id,
            description: "The ID of the project token to revoke (env: TUIST_PROJECT_TOKEN_ID)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :full_handle,
            description: "The project to revoke the token for Must be in the format of account-handle/project-handle (env: TUIST_PROJECT_TOKEN_FULL_HANDLE)",
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
