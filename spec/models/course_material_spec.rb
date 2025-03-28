require 'rails_helper'

describe CourseMaterial do
  describe 'validations' do
    let(:course_material) { create(:course_material) }

    it 'is valid' do
      expect(course_material.valid?).to be true
    end

    it 'requires a title' do
      course_material.update(title: '')
      expect(course_material.valid?).to be false
    end

    it 'requires a pub_status' do
      course_material.update(pub_status: '')
      expect(course_material.valid?).to be false
    end

    it 'requires the pub_status be in a specific list' do
      course_material.update(pub_status: 'X')
      expect(course_material.valid?).to be false
      expect(course_material.errors.full_messages).to contain_exactly('Publication Status "X" is not a valid status')
    end

    it 'requires the title to be unique' do
      duplicate_title_material = FactoryBot.build(:course_material, title: course_material.title)
      expect(duplicate_title_material.valid?).to be false
    end

    it 'allows duplicate title across organizations' do
      other_organization = create(:organization)
      other_org_category = create(:category, organization: other_organization)
      other_org_material = FactoryBot.build(:course_material, title: course_material.title, category: other_org_category)
      expect(other_org_material.valid?).to be true
    end

    it 'does not allow the title to be more than 90 chars' do
      title = ''
      90.times { title << 'a' }
      course_material.update(title: title)
      expect(course_material.valid?).to be true

      course_material.update(title: "#{title}a")
      expect(course_material.valid?).to be false
    end

    it 'requires a contributor' do
      course_material.update(contributor: '')
      expect(course_material.valid?).to be false
    end

    it 'does not allow the contributor to be more than 156 chars' do
      contributor = ''
      156.times { contributor << 'a' }
      course_material.update(contributor: contributor)
      expect(course_material.valid?).to be true

      course_material.update(contributor: "#{contributor}a")
      expect(course_material.valid?).to be false
    end

    it 'does not allow the summary to be more than 156 chars' do
      summary = ''
      74.times { summary << 'a' }
      course_material.update(summary: summary)
      expect(course_material.valid?).to be true

      course_material.update(summary: "#{summary}a")
      expect(course_material.valid?).to be false
    end

    it 'does not allow two file attachments to have the same file name' do
      create(:course_material_file, course_material: course_material)
      expect(course_material.valid?).to be true

      expect do
        create(:course_material_file, course_material: course_material)
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'does not allow two media attachments to have the same file name' do
      create(:course_material_media, course_material: course_material)
      expect(course_material.valid?).to be true

      expect do
        create(:course_material_media, course_material: course_material)
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'requires the sort_order' do
      course_material.update(sort_order: '')
      expect(course_material.valid?).to be false
    end

    it 'requires the sort_order to be greater than 0' do
      course_material.update(sort_order: 0)
      expect(course_material.valid?).to be false
    end
  end

  describe 'scopes' do
    describe 'default scope' do
      it 'returns course_materials in sort_order order' do
        course_material1 = create(:course_material, sort_order: 3)
        course_material2 = create(:course_material, sort_order: 1)
        course_material3 = create(:course_material, sort_order: 2)
        expect(described_class.all).to eq [course_material2, course_material3, course_material1]
      end
    end

    describe '.archived' do
      it 'returns all course_materials that are archived' do
        create(:course_material, pub_status: 'D')
        create(:course_material, pub_status: 'P')
        archived_course_material = create(:course_material, pub_status: 'A')
        expect(described_class.archived).to contain_exactly(archived_course_material)
      end
    end

    describe '.not_archived' do
      it 'returns all course_materials that are not archived' do
        draft_course_material = create(:course_material, pub_status: 'D')
        published_course_material = create(:course_material, pub_status: 'P')
        create(:course_material, pub_status: 'A')
        expect(described_class.not_archived).to contain_exactly(draft_course_material, published_course_material)
      end
    end

    describe '.for_organization' do
      let(:organization) { create(:organization) }
      let(:org_category) { create(:category, organization: organization) }
      let(:main_site_category) { create(:category) }

      it 'returns all course_materials for a specific organization' do
        org_course = create(:course_material, category: org_category)
        create(:course_material, category: main_site_category)

        expect(described_class.for_organization(organization)).to contain_exactly(org_course)
      end

      it 'returns course_materials for no organization (main site)' do
        main_site_course = create(:course_material, category: main_site_category)
        create(:course_material, category: org_category)

        expect(described_class.for_organization(nil)).to contain_exactly(main_site_course)
      end
    end
  end

  describe '#to_props' do
    let(:category) { create(:category) }
    let(:course_material) { create(:course_material, title: 'Test Course', category: category) }

    it 'includes expected props' do
      expected_props = {
        id: course_material.id,
        title: course_material.title,
        summary: course_material.summary,
        description: course_material.description,
        language: course_material.language,
        category: course_material.category.title,
        categoryId: course_material.category.id,
        categoryFriendlyId: course_material.category.friendly_id,
        subcategory: nil,
        subcategoryId: nil,
        status: course_material.pub_status,
        contributor: course_material.contributor,
        sortOrder: course_material.sort_order,
        courseMaterialUrl: '/courses/test-course',
        materialsDownloadUrl: '/courses/test-course/course_attachments',
        fileCount: course_material.course_material_files.count,
        imageCount: course_material.course_material_medias.count,
        videoCount: course_material.course_material_videos.count,
        providedByAtt: false,
        friendlyId: course_material.friendly_id,
        files: [],
        images: []
      }
      expect(course_material.to_props).to eq(expected_props)
    end
  end
end
