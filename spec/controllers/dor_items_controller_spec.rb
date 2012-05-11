# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DorItemsController do

  # ROUTES and MAPPING.
  describe "Paths Generated by Custom Routes:" do

    it "should map items show correctly" do
      { :get => "/items/abc" }.should route_to(
        :controller => 'dor_items', 
        :action     => 'show', 
        :id         => 'abc')
    end

  end

  # SHOW ACTION.
  describe "show action" do

    pid = 'druid:pv309jn3099'

    it "should get fedora document and assign various attributes", :integration => true do
      get :show, :id => pid
      assigns[:pid].should_not be_nil
      assigns[:document_fedora].should_not be_nil
      assigns[:descMetadata].should_not be_nil
    end

  end

end
