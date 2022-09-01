# frozen_string_literal: true
ActiveAdmin.register Artifact do
  permit_params :subject_address, :kind, :addressed_to_name, :addressed_from_name,
    :addressed_to_message, :color, :subject, :postmarked_at,
    :addressed_to_address,
    :addressed_from_address,
    photos_attributes: [:id, :image, :face, :_destroy]

  config.sort_order = 'created_at_asc'

  index do
    selectable_column

    column :id

    column 'Subject' do |artifact|
      link_to(artifact.subject, admin_artifact_path(artifact),
              target: '_blank')
    end

    column :subject_address
    column :subject_date
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

    columns do
      column do
        panel 'Artifact Photos' do
          if artifact.photos
            artifact.photos.order(:face).each do |photo|
              h3 photo.face.camelcase
              div link_to \
                image_tag(photo.image.derivation_url(:thumbnail, 400, 300)),
                edit_admin_photo_path(photo), target: '_blank'
            end
          end

          f.has_many :photos, heading: :none, allow_destroy: true do |p|
            p.input :face, as: :select, collection: Photo.faces.keys
            p.input :image, as: :file
          end
        end
      end

      column span: 3 do
        panel 'General Subject Details' do
          f.inputs do
            f.input :subject, label: 'Subject Title'
            f.input :color
            li h4 'Subject Address'
            f.fields_for :subject_address, label: 'Subject Address' do |a|
              a.input :street
              a.input :city
              a.input :state
              a.input :postcode
            end
          end
        end

        columns do
          column do
            f.inputs 'Addressed To Details' do
              f.input :addressed_to_name
              f.input :addressed_to_message, input_html: { rows: 4 }
              f.fields_for :addressed_to_address do |a|
                a.input :street
                a.input :city
                a.input :state
                a.input :postcode
              end
            end
          end

          column do
            f.inputs 'Addressed From Details' do
              f.input :addressed_from_name
              f.fields_for :addressed_from_address do |a|
                a.input :street
                a.input :city
                a.input :state
                a.input :postcode
              end
            end
          end
        end

        f.has_many :publisher, heading: 'Publisher' do |p|
          p.input :name
        end

        f.has_many :stamp, heading: 'Stamps' do |p|
          p.input :name
        end

        f.actions
      end
    end
  end
end
