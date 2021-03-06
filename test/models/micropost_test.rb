require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @micropost = Micropost.new(content: 'Lorem Ipsum' , user_id: @user.id)
  end  

  test 'should be valid' do
    assert @micropost.valid?
  end

  test 'user id should be present' do
    @micropost.user_id = nil
    assert_not @micropost.user_id?
  end  

end
