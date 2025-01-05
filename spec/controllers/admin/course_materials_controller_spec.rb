require "rails_helper"

describe Admin::CourseMaterialsController do
  let(:admin) { FactoryBot.create(:admin) }

  describe "GET #new" do
    it "assigns a new instance of a course_material" do
      sign_in admin
      get :new
      expect(assigns(:course_material)).to be_an_instance_of(CourseMaterial)
    end

    it "redirects to the homepage if not authenticated" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET #index" do
    it "assigns all course_materials" do
      sign_in admin
      learning_computers = FactoryBot.create(:course_material)
      web_browsers = FactoryBot.create(:course_material)
      FactoryBot.create(:course_material, pub_status: "A")
      get :index
      expect(assigns(:course_materials)).to contain_exactly(learning_computers, web_browsers)
    end

    it "redirects to the homepage if not authenticated" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe "POST #create" do
    let(:category) { FactoryBot.create(:category) }
    let(:file_upload) do
      fixture_file_upload(Rails.root.join("spec/fixtures/test_upload.pdf"), "application/pdf")
    end
    let(:media_upload) do
      fixture_file_upload(Rails.root.join("spec/fixtures/test.png"), "image/png")
    end
    let(:valid_attributes) do
      {
        title: "New Course Material",
        contributor: "Alejandro",
        summary: "Summary of Course Material",
        description: "Description of Course Material",
        category_id: category.id,
        pub_status: "P",
        course_material_files_attributes: {
          "0" => {
            file: file_upload
          }
        },
        course_material_medias_attributes: {
          "0" => {
            media: media_upload
          }
        },
        course_material_videos_attributes: {
          "0" => {
            url: "https://youtu.be/xXXtEK_QdNQ"
          }
        }
      }
    end

    context "when unauthenticated" do
      it "redirects to the homepage if not authenticated" do
        post :create, params: { course_material: valid_attributes }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before do
        sign_in admin
      end

      it "correctly assigns the passed in info" do
        post :create, params: { course_material: valid_attributes }
        course_material = CourseMaterial.last
        expect(course_material.title).to eq "New Course Material"
        expect(course_material.contributor).to eq "Alejandro"
        expect(course_material.summary).to eq "Summary of Course Material"
        expect(course_material.description).to eq "Description of Course Material"
        expect(course_material.pub_status).to eq "P"
        expect(course_material.course_material_files.first.present?).to be true
        expect(course_material.course_material_medias.first.present?).to be true
        expect(course_material.course_material_videos.first.present?).to be true
      end

      it "renders the new view if there is missing information" do
        invalid_attributes = {
          title: "",
          contributor: "",
          summary: "",
          description: "",
          category_id: "",
          pub_status: ""
        }
        post :create, params: { course_material: invalid_attributes }
        expect(response).to render_template :new
      end

      it "handles successful json requests" do
        expect do
          post :create, params: { course_material: valid_attributes }, xhr: true, format: :json
        end.to change(CourseMaterial, :count).by(1)

        expect(response).to have_http_status :created
        expect(response.parsed_body["message"]).to eq("Course created successfully")

        course_material = CourseMaterial.last
        expect(course_material.title).to eq "New Course Material"
        expect(course_material.contributor).to eq "Alejandro"
        expect(course_material.summary).to eq "Summary of Course Material"
        expect(course_material.description).to eq "Description of Course Material"
        expect(course_material.pub_status).to eq "P"
        expect(course_material.course_material_files.first.present?).to be true
        expect(course_material.course_material_medias.first.present?).to be true
        expect(course_material.course_material_videos.first.present?).to be true
      end

      it "handles failed json requests" do
        invalid_attributes = valid_attributes.merge({ title: "" })
        post :create, params: { course_material: invalid_attributes }, xhr: true, format: :json
        expect(response.parsed_body["error"]).to eq("Title can't be blank")
      end
    end
  end

  describe "GET #edit" do
    it "assigns the given instance of a course_material" do
      sign_in admin
      course_material = FactoryBot.create(:course_material)
      get :edit, params: { id: course_material.id }
      expect(assigns(:course_material)).to eq course_material
    end

    it "redirects to the homepage if not authenticated" do
      get :edit, params: { id: 1 }
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "PUT #update" do
    let(:category) { FactoryBot.create(:category) }
    let(:valid_attributes) do
      {
        title: "Updated Course Material",
        contributor: "Alejandro Brinkster",
        summary: "Summary of Updated Course Material",
        description: "Description of Updated Course Material",
        pub_status: "P",
        category_id: category.id
      }
    end

    context "when not authenticated" do
      it "redirects to the homepage if not authenticated" do
        put :update, params: { id: 1, course_material: valid_attributes }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      let(:course_material) { FactoryBot.create(:course_material) }

      before do
        sign_in admin
      end

      it "correctly assigns the passed in info" do
        put :update, params: { id: course_material.id, course_material: valid_attributes }
        course_material.reload
        expect(course_material.title).to eq "Updated Course Material"
        expect(course_material.contributor).to eq "Alejandro Brinkster"
        expect(course_material.summary).to eq "Summary of Updated Course Material"
        expect(course_material.description).to eq "Description of Updated Course Material"
        expect(course_material.pub_status).to eq "P"
      end

      it "removes the subcategory id if not passed in" do
        course_material.update(sub_category_id: 2)
        put :update, params: { id: course_material.id, course_material: valid_attributes }
        course_material.reload
        expect(course_material.sub_category_id.blank?).to be true
      end

      it "renders the edit view if there is missing information" do
        invalid_attributes = {
          title: "",
          contributor: "",
          summary: "",
          description: "",
          pub_status: "",
          category_id: ""
        }
        put :update, params: { id: course_material.id, course_material: invalid_attributes }
        expect(response).to render_template :edit
      end

      it "removes existing attachment" do
        cm_file = FactoryBot.create(:course_material_file, course_material: course_material)

        destroy_file_params = {
          course_material_files_attributes: {
            "0" => {
              id: cm_file.id,
              _destroy: true
            }
          }
        }

        expect do
          put :update, params: { id: course_material.id, course_material: destroy_file_params }
        end.to change { course_material.course_material_files.count }.by(-1)
      end

      it "handles successful json requests" do
        put :update, params: { id: course_material.id, course_material: valid_attributes }, xhr: true, format: :json

        expect(response).to have_http_status :ok
        expect(response.parsed_body["message"]).to eq("Course updated successfully")

        # Course material updates
        course_material.reload
        expect(course_material.title).to eq "Updated Course Material"
        expect(course_material.contributor).to eq "Alejandro Brinkster"
        expect(course_material.summary).to eq "Summary of Updated Course Material"
        expect(course_material.description).to eq "Description of Updated Course Material"
        expect(course_material.pub_status).to eq "P"
      end

      it "handles failed json requests" do
        invalid_attributes = valid_attributes.merge({ title: "" })
        put :update, params: { id: course_material.id, course_material: invalid_attributes }, xhr: true, format: :json
        expect(response.parsed_body["error"]).to eq("Title can't be blank")
      end
    end
  end

  describe "PUT #sort" do
    let(:learning_computers) { FactoryBot.create(:course_material, title: "Learning Computers") }
    let(:web_browsers) { FactoryBot.create(:course_material, title: "Web Browsers") }
    let(:operating_systems) { FactoryBot.create(:course_material, title: "Operating Systems") }

    before do
      sign_in admin
    end

    it "updates to the given sort order" do
      order = {
        "0": { id: operating_systems.id, position: "1" },
        "1": { id: learning_computers.id, position: "2" },
        "2": { id: web_browsers.id, position: "3" }
      }
      put :sort, params: { order: order }, format: :json

      [learning_computers, web_browsers, operating_systems].each(&:reload)
      expect(learning_computers.sort_order).to eq 2
      expect(web_browsers.sort_order).to eq 3
      expect(operating_systems.sort_order).to eq 1
    end
  end
end
