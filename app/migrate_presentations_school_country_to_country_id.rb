Exceptions = {
  "Vietnam"      => "VN",
  "Iran"         => "IR",
  "Cote dIvoire" => "CI",
}

def migrate_countries(table, country_field)
  table.all.map do |model|
    if model.send(country_field)
      country = Country.where(:name_en => model.send(country_field).upcase).first || Country.where(:code => Exceptions[model.send(country_field)]).first
      if country
        model.country = country
        model.save
      else
        puts 'country not found'
        p model.id
      end
    end
  end

  models_with_country_field_without_country = table.all.
    find_all {|model| model.send(country_field)}.
    find_all {|model| !model.country} 
  puts "#{table} | couldn't migrate this fields:"
  p models_with_country_field_without_country
end

migrate_countries(Presentation,      :school_country)
migrate_countries(LocalContact,      :administration_country)
migrate_countries(ScientificContact, :scientific_country)

#Presentation.all.map do |presentation|
#  presentation.acronym = presentation.school_date_a_start.strftime('%Y') + '-' + (presentation.country.try(:name_fr)||'') + '-' + (presentation.country.try(:code)||'') + '-' + presentation.id.to_s
#  presentation.save
#end
#

