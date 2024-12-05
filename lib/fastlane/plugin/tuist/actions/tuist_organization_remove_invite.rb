require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistOrganizationRemoveInviteAction < Action
      def self.run(params)
        command = ['invite']
        command.push(params[:organization_name]) if params[:organization_name]

        command.push(params[:email]) if params[:email]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Cancel pending invitation"
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
            key: :organization_name,
            description: "The name of the organization to cancel the invitation for (env: TUIST_ORGANIZATION_REMOVE_INVITE_ORGANIZATION_NAME)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :email,
            description: "The email of the user to cancel the invitation for (env: TUIST_ORGANIZATION_REMOVE_INVITE_EMAIL)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory or a subdirectory of the project (env: TUIST_ORGANIZATION_REMOVE_INVITE_PATH)",
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
