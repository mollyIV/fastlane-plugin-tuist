require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistAuthLoginAction < Action
      def self.run(params)
        command = ['login']
        command.push('--email').push(params[:email]) if params[:email]

        command.push('--password').push(params[:password]) if params[:password]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Log in a user"
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
            key: :email,
            description: "Email to authenticate with (env: TUIST_AUTH_EMAIL)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :password,
            description: "Password to authenticate with (env: TUIST_AUTH_PASSWORD)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory or a subdirectory of the project (env: TUIST_AUTH_PATH)",
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
