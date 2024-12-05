require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistPluginBuildAction < Action
      def self.run(params)
        command = ['build']
        command.push('--configuration').push(params[:configuration]) if params[:configuration]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--targets').push(params[:targets]) if params[:targets]

        command.push('--products').push(params[:products]) if params[:products]

        command.push(params[:build_tests] ? '--build-tests' : '--no-build-tests') unless params[:build_tests].nil?

        command.push(params[:show_bin_path] ? '--show-bin-path' : '--no-show-bin-path') unless params[:show_bin_path].nil?

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Builds a plugin"
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
            key: :targets,
            description: "Build the specified targets (env: TUIST_PLUGIN_BUILD_TARGETS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :products,
            description: "Build the specified products (env: TUIST_PLUGIN_BUILD_PRODUCTS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :build_tests,
            description: "Build both source and test targets (env: TUIST_PLUGIN_BUILD_BUILD_TESTS)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :show_bin_path,
            description: "Print the binary output path (env: TUIST_PLUGIN_BUILD_SHOW_BIN_PATH)",
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
