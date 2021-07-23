require "rails_helper"

describe Admin::LessonsController do

  describe "GET #new" do

    it "assigns a new instance of a lesson" do
      @course = FactoryBot.create(:course)
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      get :new, params: { course_id: @course.id }
      expect(assigns(:lesson)).to be_an_instance_of(Lesson)
    end

  end

  describe "POST #create" do

    before :each do
      @course = FactoryBot.create(:course)
    end

    let(:storyline_file) do
      fixture_file_upload(Rails.root.join("spec", "fixtures", "BasicSearch1.zip"), "application/zip")
    end

    let(:valid_attributes) do
      {
        title: "Lesson Title",
        duration: "02:15",
        course_id: @course.id,
        summary: "Lesson Summary",
        story_line: storyline_file,
        seo_page_title: "SEO Page Title",
        meta_desc: "Meta Description",
        is_assessment: false,
        pub_status: "P",
        story_line_file_name: "",
        story_line_content_type: "",
        story_line_file_size: "",
        story_line_updated_at: ""
      }
    end

    let(:invalid_attributes) do
      {
        title: "",
        duration: "",
        course_id: nil,
        summary: "",
        story_line: "",
        seo_page_title: "",
        meta_desc: "",
        is_assessment: false,
        pub_status: "",
        story_line_file_name: "",
        story_line_content_type: "",
        story_line_file_size: "",
        story_line_updated_at: ""
      }
    end

    it "correctly assigns the passed in info" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      post :create, params: { course_id: @course.id, lesson: valid_attributes }
      lesson = Lesson.last
      expect(lesson.title).to eq "Lesson Title"
      expect(lesson.duration).to eq 135
      expect(lesson.course_id).to eq @course.id
      expect(lesson.summary).to eq "Lesson Summary"
      expect(lesson.story_line.present?).to eq true
      expect(lesson.seo_page_title).to eq "SEO Page Title"
      expect(lesson.meta_desc).to eq "Meta Description"
      expect(lesson.is_assessment).to eq false
      expect(lesson.pub_status).to eq "P"
      expect(lesson.story_line_file_name).to eq "BasicSearch1.zip"
      expect(lesson.story_line_content_type).to eq "application/zip"
      expect(lesson.story_line_file_size).to eq 4_220_649
    end

    it "renders the new view if there is missing information" do
      @course = FactoryBot.create(:course)
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      post :create, params: { course_id: @course.id, lesson: invalid_attributes }
      expect(response).to render_template :new
    end

  end

  describe "GET #edit" do

    it "assigns the given instance of a lesson" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      @course = FactoryBot.create(:course, :with_lessons)
      get :edit, params: { course_id: @course.id, id: @course.lessons.first.id }
      expect(assigns(:lesson)).to eq @course.lessons.first
    end

  end

  describe "PUT #update" do

    before :each do
      @course = FactoryBot.create(:course, :with_lessons)
    end

    let(:storyline_file) do
      fixture_file_upload(Rails.root.join("spec", "fixtures", "BasicSearch1.zip"), "application/zip")
    end

    let(:valid_attributes) do
      {
        title: "Updated Lesson Title",
        duration: "02:15",
        course_id: @course.id,
        summary: "Updated Lesson Summary",
        story_line: storyline_file,
        seo_page_title: "Updated SEO Page Title",
        meta_desc: "Updated Meta Description",
        is_assessment: false,
        pub_status: "A",
        story_line_file_name: "",
        story_line_content_type: "",
        story_line_file_size: "",
        story_line_updated_at: ""
      }
    end

    let(:invalid_attributes) do
      {
        title: "",
        duration: "",
        course_id: nil,
        summary: "",
        story_line: "",
        seo_page_title: "",
        meta_desc: "",
        is_assessment: false,
        pub_status: "",
        story_line_file_name: "",
        story_line_content_type: "",
        story_line_file_size: "",
        story_line_updated_at: ""
      }
    end

    it "correctly assigns the passed in info" do
      @lesson = @course.lessons.first
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      put :update, params: { course_id: @course.id, id: @lesson.id, lesson: valid_attributes }
      @lesson.reload
      expect(@lesson.title).to eq "Updated Lesson Title"
      expect(@lesson.duration).to eq 135
      expect(@lesson.course_id).to eq @course.id
      expect(@lesson.summary).to eq "Updated Lesson Summary"
      expect(@lesson.story_line.present?).to eq true
      expect(@lesson.seo_page_title).to eq "Updated SEO Page Title"
      expect(@lesson.meta_desc).to eq "Updated Meta Description"
      expect(@lesson.is_assessment).to eq false
      expect(@lesson.pub_status).to eq "A"
      expect(@lesson.story_line_file_name).to eq "BasicSearch1.zip"
      expect(@lesson.story_line_content_type).to eq "application/zip"
      expect(@lesson.story_line_file_size).to eq 4_220_649
    end

    it "renders the edit view if there is missing information" do
      @lesson = @course.lessons.first
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      put :update, params: { course_id: @course.id, id: @lesson.id, lesson: invalid_attributes }
      expect(response).to render_template :edit
    end

  end

  describe "PUT #sort" do

    before :each do
      @course = FactoryBot.create(:course, :with_lessons)
    end

    it "should update to the given sort order" do
      @admin = FactoryBot.create(:admin)
      sign_in @admin

      first_id = @course.lessons.first.id
      second_id = @course.lessons.second.id
      third_id = @course.lessons.third.id

      order = {
        "0": { "id": third_id, "position": "1" },
        "1": { "id": first_id, "position": "2" },
        "2": { "id": second_id, "position": "3" }
      }
      put :sort, params: { course_id: @course.id, order: order }, format: :json

      @course.reload
      expect(@course.lessons.first.id).to eq third_id
      expect(@course.lessons.second.id).to eq first_id
      expect(@course.lessons.third.id).to eq second_id
    end

  end

end
