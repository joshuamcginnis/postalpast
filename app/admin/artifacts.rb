ActiveAdmin.register Artifact do
  permit_params :kind, :addressed_to_name, :addressed_from_name, :addressed_to_message, :color, :subject

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
        image_tag(photo.image_url)
      end
    end
  end
end
