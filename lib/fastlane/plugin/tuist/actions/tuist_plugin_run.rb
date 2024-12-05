require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistPluginRunAction < Action
      def self.run(params)
        command = ['run']
        command.push(params[:task]) if params[:task]

        command.push(params[:arguments]) if params[:arguments]

        command.push('--configuration').push(params[:configuration]) if params[:configuration]

        command.push('--path').push(params[:path]) if params[:path]

        command.push(params[:build_tests] ? '--build-tests' : '--no-build-tests') unless params[:build_tests].nil?

        command.push(params[:skip_build] ? '--skip-build' : '--no-skip-build') unless params[:skip_build].nil?

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Runs a plugin"
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
            key: :task,
            description: "The plugin task to run (env: TUIST_PLUGIN_RUN_TASK)",
            optional: false,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :arguments,
            description: "The arguments to pass to the plugin task (env: TUIST_PLUGIN_RUN_ARGUMENTS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :configuration,
            description: "Choose configuration (default: debug) (env: TUIST_PLUGIN_OPTIONS_CONFIGURATION)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory that contains the definition of the plugin (env: TUIST_PLUGIN_OPTIONS_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :build_tests,
            description: "Build both source and test targets (env: TUIST_PLUGIN_RUN_BUILD_TESTS)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :skip_build,
            description: "Skip building the plugin (env: TUIST_PLUGIN_RUN_SKIP_BUILD)",
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
