require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistBuildAction < Action
      def self.run(params)
        command = ['build']
        command.push(params[:scheme]) if params[:scheme]

        command.push(params[:passthrough_xcode_build_arguments]) if params[:passthrough_xcode_build_arguments]

        command.push('--device').push(params[:device]) if params[:device]

        command.push('--platform').push(params[:platform]) if params[:platform]

        command.push('--os').push(params[:os]) if params[:os]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--build-output-path').push(params[:build_output_path]) if params[:build_output_path]

        command.push('--configuration').push(params[:configuration]) if params[:configuration]

        command.push('--derived-data-path').push(params[:derived_data_path]) if params[:derived_data_path]

        command.push('--help') if params[:help]

        command.push(params[:generate] ? '--generate' : '--no-generate') unless params[:generate].nil?

        command.push(params[:clean] ? '--clean' : '--no-clean') unless params[:clean].nil?

        command.push(params[:rosetta] ? '--rosetta' : '--no-rosetta') unless params[:rosetta].nil?

        command.push(params[:generate_only] ? '--generate-only' : '--no-generate-only') unless params[:generate_only].nil?

        command.push(params[:binary_cache] ? '--binary-cache' : '--no-binary-cache') unless params[:binary_cache].nil?

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Builds a project"
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
            key: :scheme,
            description: "The scheme to be built By default it builds all the buildable schemes of the project in the current directory (env: TUIST_BUILD_OPTIONS_SCHEME)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :passthrough_xcode_build_arguments,
            description: "Arguments that will be passed through to xcodebuild (env: TUIST_BUILD_OPTIONS_PASSTHROUGH_XCODE_BUILD_ARGUMENTS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :device,
            description: "Build on a specific device (env: TUIST_BUILD_OPTIONS_DEVICE)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :platform,
            description: "Build for a specific platform (env: TUIST_BUILD_OPTIONS_PLATFORM)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :os,
            description: "Build with a specific version of the OS (env: TUIST_BUILD_OPTIONS_OS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory that contains the project to be built (env: TUIST_BUILD_OPTIONS_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :build_output_path,
            description: "The directory where build products will be copied to when the project is built (env: TUIST_BUILD_OPTIONS_BUILD_OUTPUT_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :configuration,
            description: "The configuration to be used when building the scheme (env: TUIST_BUILD_OPTIONS_CONFIGURATION)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :derived_data_path,
            description: "[Deprecated] Overrides the folder that should be used for derived data when building the project (env: TUIST_BUILD_OPTIONS_DERIVED_DATA_PATH)",
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
            key: :generate,
            description: "Force the generation of the project before building (env: TUIST_BUILD_OPTIONS_GENERATE)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :clean,
            description: "When passed, it cleans the project before building it (env: TUIST_BUILD_OPTIONS_CLEAN)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :rosetta,
            description: "When passed, append arch=x86_64 to the 'destination' to run simulator in a Rosetta mode (env: TUIST_BUILD_OPTIONS_ROSETTA)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :generate_only,
            description: "When passed, it generates the project and skips building This is useful for debugging purposes (env: TUIST_BUILD_OPTIONS_GENERATE_ONLY)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :binary_cache,
            description: "Ignore binary cache and use sources only (env: TUIST_BUILD_BINARY_CACHE)",
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
