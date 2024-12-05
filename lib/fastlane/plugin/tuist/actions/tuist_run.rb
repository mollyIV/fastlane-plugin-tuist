require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistRunAction < Action
      def self.run(params)
        command = ['run']
        command.push(params[:arguments]) if params[:arguments]

        command.push(params[:runnable]) if params[:runnable]

        command.push('--configuration').push(params[:configuration]) if params[:configuration]

        command.push('--device').push(params[:device]) if params[:device]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--os').push(params[:os]) if params[:os]

        command.push('--help') if params[:help]

        command.push('--rosetta') if params[:rosetta]

        command.push(params[:generate] ? '--generate' : '--no-generate') unless params[:generate].nil?

        command.push(params[:clean] ? '--clean' : '--no-clean') unless params[:clean].nil?

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Runs a scheme or target in the project"
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
            key: :arguments,
            description: "The arguments to pass to the runnable target during execution (env: TUIST_RUN_ARGUMENTS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :runnable,
            description: "Runnable project scheme, a preview URL, or app name with a specifier such as App@latest or App@feature-branch (env: TUIST_RUN_SCHEME)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :configuration,
            description: "The configuration to be used when building the scheme",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :device,
            description: "The simulator device name to run the target or scheme on",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory that contains the project with the target or scheme to be run",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :os,
            description: "The OS version of the simulator (env: TUIST_RUN_OS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :help,
            description: "Show help information",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :rosetta,
            description: "When passed, append arch=x86_64 to the 'destination' to run simulator in a Rosetta mode",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :generate,
            description: "Force the generation of the project before running (env: TUIST_RUN_GENERATE)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :clean,
            description: "When passed, it cleans the project before running (env: TUIST_RUN_CLEAN)",
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
