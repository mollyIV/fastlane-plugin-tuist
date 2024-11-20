require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class TuistHelper
      def self.find_and_check_tuist_cli_path!
        tuist_cli_path = self.bundled_tuist_cli_path
        UI.user_error!("Tuist CLI not found at path: #{tuist_cli_path}") unless File.exist?(tuist_cli_path)

        tuist_cli_version = Gem::Version.new(`#{tuist_cli_path} version`.scan(/(?:\d+\.?){3}/).first)

        UI.success("Using tuist #{tuist_cli_version}")
        tuist_cli_path
      end

      def self.bundled_tuist_cli_path
        File.expand_path("../../../../../ext/tuist/bin/tuist", File.dirname(__FILE__))
      end

      def self.call_tuist_cli(command)
        tuist_path = self.find_and_check_tuist_cli_path!
        command = [tuist_path] + command

        require 'open3'

        final_command = command.map { |arg| Shellwords.escape(arg) }.join(" ")

        if FastlaneCore::Globals.verbose?
          UI.command(final_command)
        end

        Open3.popen3(final_command) do |stdin, stdout, stderr, status_thread|
          out_reader = Thread.new do
            output = []

            stdout.each_line do |line|
              l = line.strip!
              UI.message(l)
              output << l
            end

            output.join
          end

          err_reader = Thread.new do
            stderr.each_line do |line|
              UI.message(line.strip!)
            end
          end

          unless status_thread.value.success?
            UI.user_error!('Error while calling Tuist CLI')
          end

          err_reader.join
          out_reader.value
        end
      end
    end
  end
end
