require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistTestAction < Action
      def self.run(params)
        command = ['test']
        command.push(params[:passthrough_xcode_build_arguments]) if params[:passthrough_xcode_build_arguments]

        command.push(params[:scheme]) if params[:scheme]

        command.push('--device').push(params[:device]) if params[:device]

        command.push('--platform').push(params[:platform]) if params[:platform]

        command.push('--os').push(params[:os]) if params[:os]

        command.push('--derived-data-path').push(params[:derived_data_path]) if params[:derived_data_path]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--configuration').push(params[:configuration]) if params[:configuration]

        command.push('--result-bundle-path').push(params[:result_bundle_path]) if params[:result_bundle_path]

        command.push('--retry-count').push(params[:retry_count]) if params[:retry_count]

        command.push('--test-plan').push(params[:test_plan]) if params[:test_plan]

        command.push('--test-targets').push(params[:test_targets]) if params[:test_targets]

        command.push('--skip-test-targets').push(params[:skip_test_targets]) if params[:skip_test_targets]

        command.push('--filter-configurations').push(params[:filter_configurations]) if params[:filter_configurations]

        command.push('--skip-configurations').push(params[:skip_configurations]) if params[:skip_configurations]

        command.push(params[:selective_testing] ? '--selective-testing' : '--no-selective-testing') unless params[:selective_testing].nil?

        command.push(params[:generate_only] ? '--generate-only' : '--no-generate-only') unless params[:generate_only].nil?

        command.push(params[:skip_ui_tests] ? '--skip-ui-tests' : '--no-skip-ui-tests') unless params[:skip_ui_tests].nil?

        command.push(params[:clean] ? '--clean' : '--no-clean') unless params[:clean].nil?

        command.push(params[:no_upload] ? '--no-upload' : '--no-no-upload') unless params[:no_upload].nil?

        command.push('--help') if params[:help]

        command.push(params[:binary_cache] ? '--binary-cache' : '--no-binary-cache') unless params[:binary_cache].nil?

        command.push(params[:rosetta] ? '--rosetta' : '--no-rosetta') unless params[:rosetta].nil?

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Tests a project"
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
            key: :passthrough_xcode_build_arguments,
            description: "xcodebuild arguments that will be passthrough",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :scheme,
            description: "The scheme to be tested By default it tests all the testable targets of the project in the current directory (env: TUIST_TEST_SCHEME)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :device,
            description: "Test on a specific device (env: TUIST_TEST_DEVICE)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :platform,
            description: "Test on a specific platform (env: TUIST_TEST_PLATFORM)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :os,
            description: "Test with a specific version of the OS (env: TUIST_TEST_OS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :derived_data_path,
            description: "[Deprecated] Overrides the folder that should be used for derived data when testing a project (env: TUIST_TEST_DERIVED_DATA_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory that contains the project to be tested (env: TUIST_TEST_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :configuration,
            description: "The configuration to be used when testing the scheme (env: TUIST_TEST_CONFIGURATION)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :result_bundle_path,
            description: "Path where test result bundle will be saved (env: TUIST_TEST_RESULT_BUNDLE_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :retry_count,
            description: "[Deprecated] Tests will retry <number> of times until success Example: if 1 is specified, the test will be retried at most once, hence it will run up to 2 times (env: TUIST_TEST_RETRY_COUNT)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :test_plan,
            description: "The test plan to run (env: TUIST_TEST_TEST_PLAN)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :test_targets,
            description: "The list of test identifiers you want to test Expected format is TestTarget[/TestClass[/TestMethod]] It is applied before --skip-testing (env: TUIST_TEST_TEST_TARGETS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :skip_test_targets,
            description: "The list of test identifiers you want to skip testing Expected format is TestTarget[/TestClass[/TestMethod]] (env: TUIST_TEST_SKIP_TEST_TARGETS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :filter_configurations,
            description: "The list of configurations you want to test It is applied before --skip-configuration (env: TUIST_TEST_CONFIGURATIONS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :skip_configurations,
            description: "The list of configurations you want to skip testing (env: TUIST_TEST_SKIP_CONFIGURATIONS)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :selective_testing,
            description: "When --no-selective-testing is passed, tuist runs all tests without using selective testing (env: TUIST_TEST_SELECTIVE_TESTING)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :generate_only,
            description: "When passed, it generates the project and skips testing This is useful for debugging purposes (env: TUIST_TEST_GENERATE_ONLY)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :skip_ui_tests,
            description: "When passed, it skips testing UI Tests targets (env: TUIST_TEST_SKIP_UITESTS)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :clean,
            description: "When passed, it cleans the project before testing it (env: TUIST_TEST_CLEAN)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :no_upload,
            description: "When passed, the result necessary for test selection is not persisted to the server (env: TUIST_TEST_NO_UPLOAD)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :help,
            description: "Show help information",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :binary_cache,
            description: "Ignore binary cache and use sources only (env: TUIST_TEST_BINARY_CACHE)",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :rosetta,
            description: "When passed, append arch=x86_64 to the 'destination' to run simulator in a Rosetta mode (env: TUIST_TEST_ROSETTA)",
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
