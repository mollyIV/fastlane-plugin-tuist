require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistAuthWhoamiAction < Action
      def self.run(params)
        command = ['whoami']
        command.push('--path').push(params[:path]) if params[:path]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Display the user's email identity currently authenticated and in use"
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
            description: "The path to the directory or a subdirectory of the project (env: TUIST_WHOAMI_PATH)",
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