require "rails_helper"

describe Constants do

  it "should have a method that defines the allowed attachment types" do
    expect(Constants.acceptable_doc_types.present?).to be true
  end

end
