# == Schema Information
#
# Table name: countries
#
#  id            :integer          not null, primary key
#  code          :string(255)
#  code_4d       :string(255)
#  name_fr       :string(255)
#  name_en       :string(255)
#  name_short_fr :string(255)
#  name_short_en :string(255)
#  region        :string(255)
#  postal_zone   :string(255)
#  dhl_zone      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Country < ActiveRecord::Base
end
