require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistOrganizationUpdateSsoAction < Action
      def self.run(params)
        command = ['sso']
        command.push(params[:organization_name]) if params[:organization_name]

        command.push('--provider').push(params[:provider]) if params[:provider]

        command.push('--organization-id').push(params[:organization_id]) if params[:organization_id]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Update the SSO provider for your organization"
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
            description: "The name of the organization for which you want to update the SSO provider for (env: TUIST_ORGANIZATION_UPDATE_SSO_ORGANIZATION_NAME)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :provider,
            description: "The SSO provider to use (env: TUIST_ORGANIZATION_UPDATE_SSO_PROVIDER)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :organization_id,
            description: "Organization ID for your SSO provider For Google, this is your Google domain (for example, if your email is tuist@tuistio, the domain would be tuistio) For Okta, it's the organization domain (such as my-orgoktacom) (env: TUIST_ORGANIZATION_UPDATE_SSO_ORGANIZATION_ID)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory or a subdirectory of the project (env: TUIST_ORGANIZATION_UPDATE_SSO_PATH)",
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
