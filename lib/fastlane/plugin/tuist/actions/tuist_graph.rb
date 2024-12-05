require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistGraphAction < Action
      def self.run(params)
        command = ['graph']
        command.push(params[:targets]) if params[:targets]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--output-path').push(params[:output_path]) if params[:output_path]

        command.push('--format').push(params[:format]) if params[:format]

        command.push('--platform').push(params[:platform]) if params[:platform]

        command.push('--algorithm').push(params[:algorithm]) if params[:algorithm]

        command.push('--help') if params[:help]

        command.push(params[:skip_external_dependencies] ? '--skip-external-dependencies' : '--no-skip-external-dependencies') unless params[:skip_external_dependencies].nil?

        command.push(params[:open] ? '--open' : '--no-open') unless params[:open].nil?

        command.push(params[:skip_test_targets] ? '--skip-test-targets' : '--no-skip-test-targets') unless params[:skip_test_targets].nil?

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Generates a graph from the workspace or project in the current directory"
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
            key: :targets,
            description: "A list of targets to filter Those and their dependent targets will be showed in the graph (env: TUIST_GRAPH_TARGETS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory that contains the project whose targets will be cached (env: TUIST_GRAPH_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :output_path,
            description: "The path where the graph will be generated (env: TUIST_GRAPH_OUTPUT_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :format,
            description: "Available formats: dot, json, png, svg (env: TUIST_GRAPH_FORMAT)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :platform,
            description: "A platform to filter Only targets for this platform will be showed in the graph Available platforms: ios, macos, tvos, watchos (env: TUIST_GRAPH_PLATFORM)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :algorithm,
            description: "Available formats: dot, neato, twopi, circo, fdp, sfdp, patchwork (env: TUIST_GRAPH_LAYOUT_ALGORITHM)",
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
            key: :skip_external_dependencies,
            description: "Skip external dependencies (env: TUIST_GRAPH_SKIP_EXTERNAL_DEPENDENCIES)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :open,
            description: "Don't open the file after generating it (env: TUIST_GRAPH_OPEN)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :skip_test_targets,
            description: "Skip Test targets during graph rendering (env: TUIST_GRAPH_SKIP_TEST_TARGETS)",
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
