require 'rails_helper'

describe MimeTypeTranslator do
  describe '#readable_mime_type' do
    it 'returns readable name of the mime type' do
      expect(described_class.readable_mime_type('application/pdf')).to eq 'PDF File'
      expect(described_class.readable_mime_type('text/csv')).to eq 'CSV File'
      expect(described_class.readable_mime_type('application/vnd.ms-excel')).to eq 'Microsoft Excel'
      expect(described_class.readable_mime_type('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')).to eq 'Microsoft Excel'
      expect(described_class.readable_mime_type('application/vnd.ms-powerpoint')).to eq 'Microsoft PowerPoint'
      expect(described_class.readable_mime_type('application/vnd.openxmlformats-officedocument.presentationml.presentation')).to eq 'Microsoft PowerPoint'
      expect(described_class.readable_mime_type('application/msword')).to eq 'Microsoft Word'
      expect(described_class.readable_mime_type('application/vnd.openxmlformats-officedocument.wordprocessingml.document')).to eq 'Microsoft Word'
      expect(described_class.readable_mime_type('application/pdf')).to eq('PDF File')
      expect(described_class.readable_mime_type('image/png')).to eq('PNG Image')
      expect(described_class.readable_mime_type('image/jpeg')).to eq('JPEG Image')
      expect(described_class.readable_mime_type('image/gif')).to eq('GIF Image')
      expect(described_class.readable_mime_type('image/webp')).to eq('WebP Image')
      expect(described_class.readable_mime_type('something else')).to eq ''
    end
  end
end
