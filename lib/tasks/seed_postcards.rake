require 'aws-sdk-s3'

namespace :seed_postcards do
  desc 'Import postcards from local images'
  task import: [:environment] do
    s3 = Aws::S3::Client.new(
      region: Rails.application.secrets.aws_s3_region,
      access_key_id: Rails.application.secrets.aws_access_key_id,
      secret_access_key: Rails.application.secrets.aws_secret_access_key)

    photos = []
    s3.list_objects(bucket: Rails.application.secrets.aws_s3_bucket,
                    prefix: 'seed').each do |response|
      photos = response.contents.map(&:key)
    end

    p photos

    #i = 0
    #while i <= postcard_images.size + 2
    #  artifact = Artifact.create()
    #  front_photo = Photo.new(artifact: artifact, face: :front)
    #  back_photo = Photo.new(artifact: artifact, face: :back)

    #  front_photo_file = File.open(postcard_images[i], 'r')
    #  back_photo_file = File.open(postcard_images[i+1], 'r')

    #  front_photo.image = front_photo_file
    #  back_photo.image = back_photo_file

    #  front_photo.save
    #  back_photo.save

    #  i += 2
    #end
  end
end
