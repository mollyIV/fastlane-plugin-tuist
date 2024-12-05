require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/tuist_helper'

module Fastlane
  module Actions
    class TuistCleanAction < Action
      def self.run(params)
        command = ['clean']
        command.push(params[:clean_categories]) if params[:clean_categories]

        command.push('--path').push(params[:path]) if params[:path]

        command.push(params[:remote] ? '--remote' : '--no-remote') unless params[:remote].nil?

        command.push('--help') if params[:help]

        Helper::TuistHelper.call_tuist_cli(command)
      end

      def self.description
        "Clean all the artifacts stored locally"
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
            key: :clean_categories,
            description: "The cache and artifact categories to be cleaned If no category is specified, everything is cleaned (env: TUIST_CLEAN_CLEAN_CATEGORIES)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "The path to the directory that contains the project that should be cleaned (env: TUIST_CLEAN_PATH)",
            optional: true,
            type: String
          ),

          FastlaneCore::ConfigItem.new(
            key: :remote,
            description: "Clean the remote cache (env: TUIST_CLEAN_REMOTE)",
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
