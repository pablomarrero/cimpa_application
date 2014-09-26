namespace :create_assign_pilotaje do
  desc "create role pilotaje"
  task default: :environment do
    pilotaje = Role.new name: 'pilotaje'
    pilotaje.save
    coprs = User.new emai: "coprs@cimpa.info", password: "evaristegalois1811"
    coprs.save
    coprs.roles << pilotaje
    coprs.save
  end
end
