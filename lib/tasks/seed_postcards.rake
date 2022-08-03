namespace :seed_postcards do
  desc 'Import postcards from local images'
  task import: [:environment] do
    source_images_path = "#{ARGV[1]}/*"

    postcard_images = Dir.glob(source_images_path).select do |path|
      path.ends_with?('.png')
    end

    postcard_images.sort!

    i = 0
    while i <= postcard_images.size + 2
      artifact = Artifact.create()
      front_photo = Photo.new(artifact: artifact, face: :front)
      back_photo = Photo.new(artifact: artifact, face: :back)

      front_photo_file = File.open(postcard_images[i], 'r')
      back_photo_file = File.open(postcard_images[i+1], 'r')

      front_photo.image = front_photo_file
      back_photo.image = back_photo_file

      front_photo.save
      back_photo.save

      i += 2
    end
  end
end
