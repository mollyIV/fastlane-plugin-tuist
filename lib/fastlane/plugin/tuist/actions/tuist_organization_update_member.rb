require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistOrganizationUpdateMemberAction < Action
      def self.run(params)
        command = ['member']
        command.push(params[:organization_name]) if params[:organization_name]

        command.push(params[:username]) if params[:username]

        command.push('--role').push(params[:role]) if params[:role]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Update a member from your organization"
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
            description: "The name of the organization for which you want to update the member for (env: TUIST_ORGANIZATION_UPDATE_MEMBER_ORGANIZATION_NAME)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :username,
            description: "The username of the member you want to update (env: TUIST_ORGANIZATION_UPDATE_MEMBER_USERNAME)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :role,
            description: "The new member role (env: TUIST_ORGANIZATION_UPDATE_MEMBER_ROLE)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory or a subdirectory of the project (env: TUIST_ORGANIZATION_UPDATE_MEMBER_PATH)",
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
