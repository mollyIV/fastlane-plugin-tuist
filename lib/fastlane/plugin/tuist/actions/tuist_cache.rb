require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistCacheAction < Action
      def self.run(params)
        command = ['cache']
        command.push(params[:targets]) if params[:targets]

        command.push('--path').push(params[:path]) if params[:path]

        command.push('--configuration').push(params[:configuration]) if params[:configuration]

        command.push('--external-only') if params[:external_only]

        command.push('--generate-only') if params[:generate_only]

        command.push('--print-hashes') if params[:print_hashes]

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Warms the local and remote cache"
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
            description: "A list of targets to cache Those and their dependant targets will be cached If no target is specified, all the project targets (excluding the external ones) and their dependencies will be cached",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory that contains the project whose targets will be cached",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :configuration,
            description: "Configuration to use for binary caching",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :external_only,
            description: "If passed, the command doesn't cache the targets passed in the `--targets` argument, but only their dependencies",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :generate_only,
            description: "When passed, it generates the project and skips warming the cache This is useful for debugging purposes",
            optional: true,
            type: Boolean
          ),

          FastlaneCore::ConfigItem.new(
            key: :print_hashes,
            description: "When passed, the hashes of the cacheable frameworks in the given project are printed",
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
