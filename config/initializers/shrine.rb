require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/memory'
require 'shrine/storage/s3'

CACHE_DIR = "#{Dir.tmpdir}/cache".freeze

if Rails.env.development?
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: CACHE_DIR),
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads')
  }
end

if Rails.env.test?
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
end

if Rails.env.production?
 s3_options = {
    access_key_id:     Rails.application.secrets.aws_access_key_id,
    secret_access_key: Rails.application.secrets.aws_secret_access_key,
    region:            Rails.application.secrets.aws_s3_region,
    bucket:            Rails.application.secrets.aws_s3_bucket
  }
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new(CACHE_DIR),
    store: Shrine::Storage::S3.new(prefix: 'store', **s3_options)
  }
end


Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :derivation_endpoint, secret_key: Rails.application.secrets.shrine_secret_key
