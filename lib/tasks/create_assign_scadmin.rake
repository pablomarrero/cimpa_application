namespace :create_assign_scadmin_role do
  desc "create role scientific_officer_admin"
  task default: :environment do
    scientific_officer_admin = Role.new name: 'scientific_officer_admin'
    scientific_officer_admin.save
    zuazua = (User.where email: "zuazua@bcamath.org").first
    zuazua.roles << scientific_officer_admin
    zuazua.save
    marisa = (User.where email: "marisa.fernandez@ehu.es").first
    marisa.roles << scientific_officer_admin
    marisa.save
  end
end
