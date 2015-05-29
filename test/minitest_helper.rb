# The next line was added to squelch a warning message in Ruby 1.9.
# It ensures we're using the gem, not the built-in Minitest
# See https://github.com/seattlerb/minitest/#install
gem 'minitest'

require 'minitest/autorun'

if ENV['COVERAGE']
  require 'coveralls'
  require 'simplecov'

  SimpleCov.start do
    add_filter '/test/'
  end
end

require File.join(File.dirname(__FILE__), '../lib/fog/google.rb')

Coveralls.wear! if ENV['COVERAGE']

# Use :test credentials in ~/.fog for live integration testing
# XXX not sure if this will work on Travis CI or not
Fog.credential = :test

# Helpers

TEST_ZONE = "us-central1-a"
TEST_REGION = "us-central1"
TEST_SIZE_GB = 10
TEST_MACHINE_TYPE = "n1-standard-1"
# XXX This depends on a public image in gs://fog-test-bucket; there may be a better way to do this
# The image was created like so: https://cloud.google.com/compute/docs/images#export_an_image_to_google_cloud_storage
TEST_RAW_DISK_SOURCE = "http://storage.googleapis.com/fog-test-bucket/fog-test-raw-disk-source.image.tar.gz"

class FogIntegrationTest < MiniTest::Test
  def namespaced_name
    "#{self.class.to_s}_#{name}"
  end
end
