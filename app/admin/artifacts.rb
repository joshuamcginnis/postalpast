ActiveAdmin.register Artifact do
  permit_params :kind, :addressed_to_name, :addressed_from_name,
    :addressed_to_message, :color, :subject, :postmarked_at

  index do
    selectable_column

    column :id

    column 'Subject' do |artifact|
      link_to(artifact.subject, admin_artifact_path(artifact),
              target: '_blank')
    end

    column :color
    column :postmarked?
    column :postmarked_at

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
    panel 'Photos' do
      attributes_table_for artifact.photos do
        row :face
        row :image do |photo|
          link_to(image_tag(photo.image.derivation_url(:thumbnail, 600, 400)),
                  photo.image_url, target: '_blank')
        end
      end
    end

    attributes_table do
      row :subject
      row :subject_address
      row :addressed_to_name
      row :addressed_to_message
      row :to_address
      row :addressed_from_name
      row :from_address
      row :color
      row :postmarked?
      row :postmarked_at
      row :postmark_address
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
