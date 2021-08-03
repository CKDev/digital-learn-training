class IdpSettingsAdapter
  def self.settings(idp_entity_id)
    idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new

    metadata_file = File.join(Rails.root, 'config', 'sso_metadata', "#{Rails.env}.xml")
    metadata = File.read(metadata_file)
    idp_metadata_parser.parse_to_hash(metadata)
  end
end
