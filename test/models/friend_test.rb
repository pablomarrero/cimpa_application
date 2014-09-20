# == Schema Information
#
# Table name: friends
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  friend_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
