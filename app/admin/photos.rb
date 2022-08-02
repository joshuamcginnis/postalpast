ActiveAdmin.register Photo do
  permit_params :artifact_id, :image, :face

  index do
    selectable_column

    column 'Artifact' do |photo|
      link_to photo.artifact.subject, admin_artifact_path(photo.artifact)
    end

    column :face

    column 'Image' do |photo|
      image_tag(photo.image_url)
    end

    actions
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :artifact, as: :select, collection: Artifact.all.collect { |a| ["#{a.id} - #{a.subject}", a.id] }
      f.input :face
      f.input :image, as: :file, label: 'Image File'
    end

    actions
  end
end
