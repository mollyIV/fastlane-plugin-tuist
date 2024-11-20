require 'mkmf'
require 'open-uri'
require 'fileutils'
require 'zip'
require 'tmpdir'

# Read the version from lib/fastlane/plugin/tuist/version.rb
version_file = File.join(__dir__, '..', '..', 'lib', 'fastlane', 'plugin', 'tuist', 'version.rb')
version = nil

File.open(version_file, 'r') do |file|
  file.each_line do |line|
    if line =~ /VERSION\s*=\s*['"](.*)['"]/
      version = $1
      break
    end
  end
end

raise "Version not found in #{version_file}" unless version

# URL of the binary zip file
binary_url = "https://github.com/tuist/tuist/releases/download/#{version}/tuist.zip"

# Path where the binary will be extracted
binary_dir = File.join(Dir.pwd, "bin")
binary_path = File.join(binary_dir, "tuist")

# Create the directory if it doesn't exist
FileUtils.mkdir_p(binary_dir)

# Use a temporary directory to save the zip file
Dir.mktmpdir do |tmpdir|
  zip_path = File.join(tmpdir, "tuist.zip")

  # Download the zip file
  open(zip_path, 'wb') do |file|
    file << URI.open(binary_url).read
  end

  # Extract only the tuist binary from the zip file
  Zip::File.open(zip_path) do |zip_file|
    zip_file.each do |entry|
      if entry.name == 'tuist'
        entry.extract(binary_path) { true }
      end
    end
  end

  # Make the binary executable
  File.chmod(0755, binary_path)
end

# Create a dummy Makefile
File.open('Makefile', 'w') do |file|
    file.write("all:\n")
    file.write("\t\n")
end
