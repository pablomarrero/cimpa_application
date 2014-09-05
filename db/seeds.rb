# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(email: 'zuazua@bcamath.org', password: 'C1mp4Syst3m')
u.add_role :scientific_officer
u = User.create(email: 'jean-marc.azais@math.univ-toulouse.fr', password: 'C1mp4Syst3m')
u.add_role :scientific_officer
u = User.create(email: 'viviane.baladi@ens.fr',  password: 'C1mp4Syst3m')
u.add_role :scientific_officer
u = User.create(email: 'ebaskoro@gmail.com',  password: 'C1mp4Syst3m')
u.add_role :scientific_officer
u = User.create(email: 'brenner@math.lsu.edu',  password: 'C1mp4Syst3m')
u.add_role :scientific_officer
u = User.create(email: 'marisa.fernandez@ehu.es',  password: 'C1mp4Syst3m')
u.add_role :scientific_officer
u = User.create(email: 'villani@ihp.fr',  password: 'C1mp4Syst3m')
u.add_role :scientific_officer
u = User.create(email: 'hlopes@im.ufrj.br',  password: 'C1mp4Syst3m')
u.add_role :scientific_officer
u = User.create(email: 'ouknine@ucam.ac.ma',  password: 'C1mp4Syst3m')
u.add_role :scientific_officer
u = User.create(email: 'cdiprisc@ivic.gob.ve',  password: 'C1mp4Syst3m')
u.add_role :scientific_officer
u = User.create(email: 'ragnip@math.uio.no',  password: 'C1mp4Syst3m')
u.add_role :scientific_officer
u = User.create(email: 'sujatha@math.tifr.res.in', password: 'C1mp4Syst3m')