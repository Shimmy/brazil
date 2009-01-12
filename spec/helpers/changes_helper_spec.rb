require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ChangesHelper do
  
  describe "should call change action link and" do
    before(:each) do
      @change = mock_model(Change)
      @activity = mock_model(Activity)
      @app = mock_model(App)

      @activity.stub!(:app).and_return(@app)
      @change.stub!(:activity).and_return(@activity)
    end

    it "display a button with value Approve" do
      @change.stub!(:state).and_return(Change::STATE_SUGGESTED)
      button_name = 'Approve'
      helper.stub!(:activity_show_dev_actions).and_return(true)
      helper.change_action_link(@change).should == link_to(button_name, edit_app_activity_change_path(@change.activity.app, @change.activity, @change), :class => 'edit_change_button')      
    end

    it "display a button with value Edit" do
      @change.stub!(:state).and_return(Change::STATE_SAVED)
      button_name = 'Edit'
      helper.stub!(:activity_show_dev_actions).and_return(true)
      helper.change_action_link(@change).should == link_to(button_name, edit_app_activity_change_path(@change.activity.app, @change.activity, @change), :class => 'edit_change_button')      
    end

    it "display no button since unknown change state" do
      @change.stub!(:state).and_return(-1)
      button_name = 'Foo'
      helper.stub!(:activity_show_dev_actions).and_return(true)
      helper.change_action_link(@change).should == nil
    end
    
    it "display no button since activity should have no actions" do
      @change.stub!(:state).and_return(Change::STATE_SAVED)
      button_name = 'Foo'
      helper.stub!(:activity_show_dev_actions).and_return(false)
      helper.change_action_link(@change).should == nil
    end
  end

end
