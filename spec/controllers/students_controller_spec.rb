require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe '#index' do
    it "assigns all students to @students"
    it "renders :index template"
    it "redirects when user is not logged in"
  end

  describe "#show" do
    it "assigns @student"
    it "renders :show template"
    it "redirects when user is not logged in"
  end

  describe "#new" do
    it "assigns a new student to @student"
    it "renders :new template"
    it "redirects when not signed in"
  end

  describe "#create" do
    describe "with valid input" do
      it "creates a new student"
      it "redirects to root_path"
    end

    describe "with invalid input" do
      it "doesn't create a new student"
      it "renders :new template"
    end
  end

  describe "#edit" do
    it "assigns @student"
    it "renders :edit template"
  end

  describe "#update" do
    describe "with valid input" do
      it "updates the student's attributes"
      it "redirects to student's show page"
    end

    describe "with invalid input" do
      it "doesn't update the student's attributes"
      it "renders :edit template"
    end
  end

  describe "#destroy" do
    it "deletes the user"
  end

  # TODO describe "#find_student"
end
