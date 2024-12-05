require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistOrganizationShowAction < Action
      def self.run(params)
        command = ['show']
        command.push(params[:organization_name]) if params[:organization_name]

        command.push('--path').push(params[:path]) if params[:path]

        command.push(params[:json] ? '--json' : '--no-json') unless params[:json].nil?

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Show information about the specified organization"
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
            description: "The name of the organization to show (env: TUIST_ORGANIZATION_SHOW_ORGANIZATION_NAME)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory or a subdirectory of the project (env: TUIST_ORGANIZATION_SHOW_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :json,
            description: "The output in JSON format (env: TUIST_ORGANIZATION_SHOW_JSON)",
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
