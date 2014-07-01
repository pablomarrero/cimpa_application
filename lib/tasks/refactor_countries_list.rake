namespace :refactor_countries_list do
  desc "add country_id to presentation, local_contact and scientific_contact"
  task default: [:add_country_id_to_presentation, :add_country_id_to_local_contact, :add_country_id_to_scientific_contact]  do
  end

  desc "add country_id to presentation, based on school_country"
  task add_country_id_to_presentation: :environment do
    migrate_countries(Presentation,      :school_country)
  end

  desc "add country_id to local_contact, based on administration_country"
  task add_country_id_to_local_contact: :environment do
    migrate_countries(LocalContact,      :administration_country)
  end

  desc "add country_id to scientific_contact, based on scientific_country"
  task add_country_id_to_scientific_contact: :environment do
    migrate_countries(ScientificContact, :scientific_country)
  end
end

def migrate_countries(table, country_field)
  exceptions = {
    "Vietnam"      => "VN",
    "Iran"         => "IR",
    "Cote dIvoire" => "CI",
  }

  table.all.map do |model|
    if model.send(country_field)
      country = Country.where(:name_en => model.send(country_field).upcase).first || Country.where(:code => exceptions[model.send(country_field)]).first
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
  unless models_with_country_field_without_country.empty?
    puts "#{table} | couldn't migrate this fields:"
    p models_with_country_field_without_country
  end
end
