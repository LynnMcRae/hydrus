# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HydrusItemsController do

  # ROUTES and MAPPING.
  describe "Paths Generated by Custom Routes:" do

    it "should map items show correctly" do
      { :get => "/items/abc" }.should route_to(
        :controller => 'hydrus_items', 
        :action     => 'show', 
        :id         => 'abc')
    end

  end

  # SHOW ACTION.
  describe "show action" do

    pid = 'druid:oo000oo0001'

    it "should get fedora document and assign various attributes", :integration => true do
      controller.stub(:current_user).and_return(mock_user)
      get :show, :id => pid
      assigns[:document_fedora].should be_nil
      response.should redirect_to :hydrus_items      
    end

  end

  describe "update" do
    describe "file upload" do
      before(:all) do
        @pid = "druid:oo000oo0001"
        @file = fixture_file_upload("/../../spec/fixtures/files/fixture.html", "text/html")
      end
      it "should update the file successfully" do
        controller.stub(:current_user).and_return(mock_authed_user)
        put :update, :id => @pid, "files" => [@file]
        response.should redirect_to(hydrus_item_path(@pid))
        flash[:notice].should =~ /Your changes have been saved/
        flash[:notice].should =~ /'fixture.html' uploaded/
        Hydrus::Item.find(@pid).files.map{|file| file.filename }.include?("fixture.html").should be_true
      end
    end
  end

end
