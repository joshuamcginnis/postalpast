# frozen_string_literal: true

require 'aws-sdk-s3'

PREFIX = 'seed'

namespace :seed_postcards do
  desc 'Import postcards from local images'
  task import: [:environment] do
    bucket = Rails.application.secrets.aws_s3_bucket

    s3 = Aws::S3::Client.new(
      region: Rails.application.secrets.aws_s3_region,
      access_key_id: Rails.application.secrets.aws_access_key_id,
      secret_access_key: Rails.application.secrets.aws_secret_access_key
    )

    seed_images = s3.list_objects(bucket: bucket, prefix: PREFIX)
                    .contents.map(&:key)

    puts "#{seed_images.size} seed images found."

    seed_images.each_with_index do |key, index|
      ActiveRecord::Base.transaction do
        artifact = index.even? ? Artifact.create! : Artifact.last
        face = index.even? ? :front : :back

        image_name = key.gsub("#{PREFIX}/", '')
        s3_obj = s3.get_object(bucket: bucket, key: key).body

        photo = Photo.new(face: face, artifact: artifact)

        attacher = photo.image_attacher
        attacher.attach(s3_obj, metadata: { 'filename' => image_name })
        photo.save!

        p "Added #{image_name}:#{face}:#{photo.id} to artifact #{artifact.id}."
      end
    end
  end
end
