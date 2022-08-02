ActiveAdmin.register Artifact do
  permit_params :kind, :addressed_to_name, :addressed_from_name, :addressed_to_message, :color, :subject

  index do
    selectable_column

    column 'Subject' do |artifact|
      link_to(artifact.subject, admin_artifact_path(artifact),
              target: '_blank')
    end

    column :color

    column 'Front' do |artifact|
      photo = artifact.photos.find_by_face(:front).image
      link_to(image_tag(photo.derivation_url(:thumbnail, 100, 100)),
              photo.url,
              target: '_blank')
    end

    column 'Back' do |artifact|
      photo = artifact.photos.find_by_face(:back).image
      link_to(image_tag(photo.derivation_url(:thumbnail, 100, 100)),
              photo.url,
              target: '_blank')
    end

    column 'Created', :created_at
    column 'Updated', :updated_at
    actions
  end

  show do
    attributes_table do
      row :subject
      row :addressed_to_name
      row :addressed_from_name
      row :addressed_to_message
      row :color
      row :created_at
      row :updated_at
    end

    attributes_table_for artifact.photos do
      row :face
      row :image do |photo|
        link_to(image_tag(photo.image.derivation_url(:thumbnail, 400, 200)),
                photo.image_url)
      end
    end
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
