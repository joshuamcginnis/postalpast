# frozen_string_literal: true

namespace :artifacts do
  desc 'Moves the value of street in address fields to address_1'
  task migrate_street_to_address_1: :environment do
    Artifact.all.each do |artifact|
      Artifact::ADDRESS_FIELDS.each do |field|
        next unless artifact[field] && artifact[field]['street'].present?

        artifact[field]['address_1'] = artifact[field]['street']
        artifact[field].delete('street')

        p artifact.id, artifact.save
      end
    end
  end
end
