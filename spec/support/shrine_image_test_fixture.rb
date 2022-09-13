module ShrineImageTestFixture
  module_function

  TEST_IMAGE = 'spec/fixtures/data/image.png'

  def image_data
    attacher = Shrine::Attacher.new
    attacher.set(uploaded_image)

    ## if you're processing derivatives
    #attacher.set_derivatives(
    #  large:  uploaded_image,
    #  medium: uploaded_image,
    #  small:  uploaded_image,
    #)

    attacher.column_data
  end

  def uploaded_image
    file = File.open(TEST_IMAGE, binmode: true)

    # for performance we skip metadata extraction and assign test metadata
    uploaded_file = Shrine.upload(file, :store)
    uploaded_file.metadata.merge!(
      'size'      => File.size(file.path),
      'mime_type' => 'image/png',
      'filename'  => 'test.png',
    )

    uploaded_file
  end
end
