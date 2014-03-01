class Presentation < ActiveRecord::Base
  extend Enumerize
  has_paper_trail

  belongs_to :user
  enumerize :project_type, in: [:fundamental, :applied, :mixed]
  enumerize :proposal_state, in: [:primary_fill, :pre_proposal, :final_proposal]
  enumerize :subject_clasification, in: ['00','01','03','05','06','08','11','12', '13','14','15','16','17','18','19','20','22','26','28','30','31','32','33', '34','35','37','39','40','41','42','43','44','45','46','47','49','51','52','53','54','55','57','58','60','62','65','68','70','74','76', '78','80','81','82','83','85','86','90','91','92','93','94','97']

  countries = ['Afghanistan','Akrotiri','Albania','Algeria','American Samoa','Andorra','Angola',
    'Anguilla','Antarctica','Antigua and Barbuda','Argentina','Armenia','Aruba','Ashmore and Cartier Islands',
    'Australia','Austria','Azerbaijan','Bahamas','Bahrain','Bangladesh','Barbados','Bassas da India','Belarus',
    'Belgium','Belize','Benin','Bermuda','Bhutan','Bolivia','Bosnia and Herzegovina','Botswana','Bouvet Island',
    'Brazil','British Indian Ocean Territory','British Virgin Islands','Brunei','Bulgaria','Burkina Faso',
    'Burma','Burundi','Cambodia','Cameroon','Canada','Cape Verde','Cayman Islands','Central African Republic',
    'Chad','Chile','China','Christmas Island','Clipperton Island','Cocos (Keeling) Islands','Colombia',
    'Comoros','Democratic Republic of the Congo','Republic of the Congo','Cook Islands','Coral Sea Islands',
    'Costa Rica','Cote dIvoire','Croatia','Cuba','Cyprus','Czech Republic','Denmark','Dhekelia','Djibouti',
    'Dominica','Dominican Republic','Ecuador','Egypt','El Salvador','Equatorial Guinea','Eritrea','Estonia',
    'Ethiopia','Europa Island','Falkland Islands (Islas Malvinas)','Faroe Islands','Fiji','Finland','France',
    'French Guiana','French Polynesia','French Southern and Antarctic Lands','Gabon','Gambia, The','Gaza Strip',
    'Georgia','Germany','Ghana','Gibraltar','Glorioso Islands','Greece','Greenland','Grenada','Guadeloupe',
    'Guam','Guatemala','Guernsey','Guinea','Guinea-Bissau','Guyana','Haiti','Heard Island and McDonald Islands',
    'Holy See (Vatican City)','Honduras','Hong Kong','Hungary','Iceland','India','Indonesia','Iran','Iraq',
    'Ireland','Isle of Man','Israel','Italy','Jamaica','Jan Mayen','Japan','Jersey','Jordan','Juan de Nova Island',
    'Kazakhstan','Kenya','Kiribati','Korea, North','Korea, South','Kuwait','Kyrgyzstan','Laos','Latvia','Lebanon',
    'Lesotho','Liberia','Libya','Liechtenstein','Lithuania','Luxembourg','Macau','Macedonia','Madagascar','Malawi',
    'Malaysia','Maldives','Mali','Malta','Marshall Islands','Martinique','Mauritania','Mauritius','Mayotte',
    'Mexico','Micronesia, Federated States of','Moldova','Monaco','Mongolia','Montserrat','Morocco','Mozambique',
    'Namibia','Nauru','Navassa Island','Nepal','Netherlands','Netherlands Antilles','New Caledonia','New Zealand',
    'Nicaragua','Niger','Nigeria','Niue','Norfolk Island','Northern Mariana Islands','Norway','Oman','Pakistan',
    'Palau','Panama','Papua New Guinea','Paracel Islands','Paraguay','Peru','Philippines','Pitcairn Islands',
    'Poland','Portugal','Puerto Rico','Qatar','Reunion','Romania','Russia','Rwanda','Saint Helena',
    'Saint Kitts and Nevis','Saint Lucia','Saint Pierre and Miquelon','Saint Vincent and the Grenadines',
    'Samoa','San Marino','Sao Tome and Principe','Saudi Arabia','Senegal','Serbia and Montenegro','Seychelles',
    'Sierra Leone','Singapore','Slovakia','Slovenia','Solomon Islands','Somalia','South Africa',
    'South Georgia and the South Sandwich Islands','Spain','Spratly Islands','Sri Lanka','Sudan','Suriname',
    'Svalbard','Swaziland','Sweden','Switzerland','Syria','Taiwan','Tajikistan','Tanzania','Thailand',
    'Timor-Leste','Togo','Tokelau','Tonga','Trinidad and Tobago','Tromelin Island','Tunisia','Turkey','Turkmenistan',
    'Turks and Caicos Islands','Tuvalu','Uganda','Ukraine','United Arab Emirates','United Kingdom','United States',
    'Uruguay','Uzbekistan','Vanuatu','Venezuela','Vietnam','Virgin Islands','Wake Island','Wallis and Futuna',
    'West Bank','Western Sahara','Yemen','Zambia','Zimbabwe']
  enumerize :administration_place, in: countries
  enumerize :scientific_place, in: countries
  enumerize :school_country, in: countries 
  has_attached_file :administration_cv, 
                    :url => "/assets/presentation/:id/administration_cv/:basename.:extension",
                    :path => ":rails_root/public/assets/presentation/:id/administration_cv/:basename.:extension"
  validates_attachment :administration_cv, :content_type => {:content_type => 'application/pdf' , :message => 'Only pdf'}

  has_attached_file :scientific_cv, 
                    :url => "/assets/presentation/:id/scientific_cv/:basename.:extension",
                    :path => ":rails_root/public/assets/presentation/:id/scientific_cv/:basename.:extension"
  validates_attachment :scientific_cv, :content_type => {:content_type => 'application/pdf' , :message => 'Only pdf'}

  has_many :provisional_budgets
  accepts_nested_attributes_for :provisional_budgets, :reject_if => :all_blank, :allow_destroy => true
  has_many :anticipated_fundings
  accepts_nested_attributes_for :anticipated_fundings, :reject_if => :all_blank, :allow_destroy => true


  validates :similar_project, presence: true, if: :pre_proposal? || :final_proposal?
  validates :completely_read, presence: true, if: :pre_proposal? || :final_proposal?
  validates :research_school_title, presence: true, if: :pre_proposal? || :final_proposal?
  validates :project_type, presence: true, if: :pre_proposal? || :final_proposal?
  validates :subject_clasification, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_place, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_country, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_date_a_start, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_date_a_finish, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_date_b_start, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_date_b_finish, presence: true, if: :pre_proposal? || :final_proposal?
  validates :scientific_content, presence: true, if: :pre_proposal? || :final_proposal?
  validates :members_of_scientific_committee, presence: true, if: :pre_proposal? || :final_proposal?
  validates :motivation, presence: true, if: :pre_proposal? || :final_proposal?
  validates :confirmation_completely_read, presence: true, if: :pre_proposal? || :final_proposal?

  validates :members_of_local_committee, presence: true, if: :final_proposal?
  validates :local_institution_description, presence: true, if: :final_proposal?
  validates :related_scientific_work, presence: true, if: :final_proposal?
  validates :infrastructure, presence: true, if: :final_proposal?
  validates :tentative_schedule, presence: true, if: :final_proposal?
  validates :women_percentage_scientific, presence: true, if: :final_proposal?
  validates :women_percentage_local, presence: true, if: :final_proposal?
  validates :women_percentage_course, presence: true, if: :final_proposal?
  validates :how_much_cimpa, presence: true, if: :final_proposal?
  validates :how_much_cimpa_percentage, presence: true, if: :final_proposal?
  validates :young_people, presence: true, if: :final_proposal?
  validates :average_time_scientific, presence: true, if: :final_proposal?
  validates :day_time_scientific, presence: true, if: :final_proposal?
  validates :administration_name, presence: true, if: :final_proposal?
  validates :administration_place, presence: true, if: :final_proposal?
  validates :administration_email, presence: true, if: :final_proposal?
  validates :administration_phone, presence: true, if: :final_proposal?
  validates :administration_cv, presence: true, if: :final_proposal?
  validates :scientific_name, presence: true, if: :final_proposal?
  validates :scientific_place, presence: true, if: :final_proposal?
  validates :scientific_email, presence: true, if: :final_proposal?
  validates :scientific_phone, presence: true, if: :final_proposal?
  validates :scientific_cv, presence: true, if: :final_proposal?
  validates :tentative_schedule, presence: true, if: :final_proposal?
  validates :tentative_schedule, presence: true, if: :final_proposal?

  def final_proposal?
    self.proposal_state == 'final_proposal'
  end
  def pre_proposal?
    self.proposal_state == 'pre_proposal'
  end

end
