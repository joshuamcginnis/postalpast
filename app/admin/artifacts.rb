# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Artifact do
  permit_params :kind,
                :addressed_to_name,
                :addressed_from_name,
                :addressed_to_message,
                :color,
                :subject,
                :subject_date,
                :subject_description,
                :postmarked_at,
                subject_address: Artifact::ADDRESS_FIELD_ATTRIBUTES,
                to_address: Artifact::ADDRESS_FIELD_ATTRIBUTES,
                from_address: Artifact::ADDRESS_FIELD_ATTRIBUTES,
                photos_attributes: %i[id image face _destroy]

  config.sort_order = 'created_at_asc'

  controller do
    def update
      super do |success|
        success.html { redirect_to collection_path }
      end
    end
  end

  action_item :save_and_next, only: :edit do
    if artifact.next
      link_to 'Save and next', edit_admin_artifact_path(artifact.next)
    end
  end

  # list artifacts page
  index do
    selectable_column

    column :id

    column 'Subject' do |artifact|
      link_to(artifact.subject, edit_admin_artifact_path(artifact),
              target: '_blank', rel: 'noopener')
    end

    column :subject_address
    column :subject_date
    column :color
    column :postmarked?
    column :postmarked_at

    column 'Front' do |artifact|
      photo = artifact.photos.find_by(face: :front)&.image
      if photo
        link_to(image_tag(photo.derivation_url(:thumbnail, 100, 100)),
                photo.url,
                target: '_blank', rel: 'noopener')
      end
    end

    column 'Back' do |artifact|
      photo = artifact.photos.find_by(face: :back)&.image
      if photo
        link_to(image_tag(photo.derivation_url(:thumbnail, 100, 100)),
                photo.url,
                target: '_blank', rel: 'noopener')
      end
    end

    column 'Updated', :updated_at

    column 'Actions' do |artifact|
      link_to 'Edit', edit_admin_artifact_path(artifact), class: 'button'
    end
  end

  # show artifact
  show do
    panel 'Photos' do
      attributes_table_for artifact.photos do
        row :face
        row :image do |photo|
          link_to(image_tag(photo.image.derivation_url(:thumbnail, 600, 400)),
                  photo.image_url, target: '_blank', rel: 'noopener')
        end
      end
    end

    attributes_table do
      row :subject
      row :subject_date
      row :subject_description
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
          if artifact&.photos
            artifact.photos.order(:face).each do |photo|
              h3 photo.face.camelcase
              div link_to \
                image_tag(photo.image.derivation_url(:thumbnail, 250, 200)),
                photo.image_url, target: '_blank', rel: 'noopener'
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
            f.input :subject_date, as: :datepicker
            f.input :subject_description, input_html: { rows: 10 }
            f.input :color
            li b 'Subject Address'

            f.fields_for :subject_address, label: 'Subject Address' do |a|
              a.input :business_name,  as: :hstore_address
              a.input :address_line_1, as: :hstore_address
              a.input :address_line_2, as: :hstore_address
              a.input :city,           as: :hstore_address
              a.input :state,          as: :hstore_address
              a.input :postcode,       as: :hstore_address
            end
          end
        end

        columns do
          column do
            f.inputs 'Addressed To Details' do
              f.input :addressed_to_name
              f.input :addressed_to_message, input_html: { rows: 4 }
              f.fields_for :to_address do |a|
                a.input :business_name,  as: :hstore_address
                a.input :address_line_1, as: :hstore_address
                a.input :address_line_2, as: :hstore_address
                a.input :city,           as: :hstore_address
                a.input :state,          as: :hstore_address
                a.input :postcode,       as: :hstore_address
              end
            end
          end

          column do
            f.inputs 'Addressed From Details' do
              f.input :addressed_from_name
              f.fields_for :from_address do |a|
                a.input :business_name,  as: :hstore_address
                a.input :address_line_1, as: :hstore_address
                a.input :address_line_2, as: :hstore_address
                a.input :city,           as: :hstore_address
                a.input :state,          as: :hstore_address
                a.input :postcode,       as: :hstore_address
              end
            end
          end
        end

        columns do
          panel 'Postmark Details' do
            f.inputs do
              f.input :postmarked_at, as: :datetime_picker
              f.fields_for :to_address, label: 'Postmark Address' do |a|
                a.input :city,           as: :hstore_address
                a.input :state,          as: :hstore_address
              end
            end
          end
        end

        f.actions
      end

      column do
        panel 'Stamp' do
          f.has_many :stamp, heading: :none do |s|
            s.input :name
            s.input :price
          end
        end

        panel 'Publisher' do
          f.has_many :publisher, heading: :none do |p|
            p.input :name
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
