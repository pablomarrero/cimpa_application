# == Schema Information
#
# Table name: evaluations
#
#  id           :integer          not null, primary key
#  date_due     :date
#  person_id    :integer
#  organization :text
#  standard     :text
#  suitability  :text
#  funding      :text
#  report       :text
#  assessment   :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Evaluation < ActiveRecord::Base
end
