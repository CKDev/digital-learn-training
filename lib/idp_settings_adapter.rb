class IdpSettingsAdapter
  def self.settings(_idp_entity_id)
    idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new

    metadata_file = Rails.root.join('config', 'sso_metadata', "#{Rails.env}.xml").to_s
    metadata = File.read(metadata_file)
    idp_metadata_parser.parse_to_hash(metadata)
  end
end
