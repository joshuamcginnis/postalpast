require 'aws-sdk-s3'

PREFIX = 'seed'.freeze

namespace :seed_postcards do
  desc 'Import postcards from local images'
  task import: [:environment] do
    bucket = Rails.application.secrets.aws_s3_bucket

    s3 = Aws::S3::Client.new(
      region: Rails.application.secrets.aws_s3_region,
      access_key_id: Rails.application.secrets.aws_access_key_id,
      secret_access_key: Rails.application.secrets.aws_secret_access_key)

    seed_images = s3.list_objects(bucket: bucket, prefix: PREFIX)
      .contents.map(&:key)

    puts "#{seed_images.size} seed images found."

    seed_images[0...6].each_with_index do |key, index|
      ActiveRecord::Base.transaction do
        artifact = index % 2 == 0 ? Artifact.create! : Artifact.last
        face = index % 2 == 0 ? :front : :back

        image_name = key.gsub("#{PREFIX}/", '')
        tmp_image = "/tmp/#{image_name}"

        s3.get_object(response_target: tmp_image, bucket: bucket, key: key)

        photo = Photo.new(face: face, artifact: artifact)
        photo.image = File.open(tmp_image)

        photo.save!
        File.delete(tmp_image)

        p "Added #{image_name}:#{face} to artifact #{artifact.id}."
      end
    end
  end
end
