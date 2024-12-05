require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistProjectUpdateAction < Action
      def self.run(params)
        command = ['update']
        command.push(params[:full_handle]) if params[:full_handle]

        command.push('--default-branch').push(params[:default_branch]) if params[:default_branch]

        command.push('--repository-url').push(params[:repository_url]) if params[:repository_url]

        command.push('--visibility').push(params[:visibility]) if params[:visibility]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Update project settings"
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
            description: "The full handle of the project to update Must be in the format of account-handle/project-handle",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :default_branch,
            description: "Set the default branch name for the repository linked to the project",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :repository_url,
            description: "Set the connected Git repository Example: --repository-url https://githubcom/tuist/tuist",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :visibility,
            description: "Set the project's visibility When private, only project's members have access to the project Public projects are accessible by anyone",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the Tuist project",
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
