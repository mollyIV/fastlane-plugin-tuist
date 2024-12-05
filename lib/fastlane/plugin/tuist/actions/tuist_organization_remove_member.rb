require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistOrganizationRemoveMemberAction < Action
      def self.run(params)
        command = ['member']
        command.push(params[:organization_name]) if params[:organization_name]

        command.push(params[:username]) if params[:username]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Remove a member from your organization"
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
            description: "The name of the organization to remove the organization member from (env: TUIST_ORGANIZATION_REMOVE_MEMBER_ORGANIZATION_NAME)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :username,
            description: "The username of the member you want to remove from the organization (env: TUIST_ORGANIZATION_REMOVE_MEMBER_USERNAME)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory or a subdirectory of the project (env: TUIST_ORGANIZATION_REMOVE_MEMBER_PATH)",
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
