# frozen_string_literal: true

require "spec_helper"

RSpec.describe "sandbox" do
  it "something test" do
    visit "/"
    expect(page).to have_text("Hello world!")
  end
end
