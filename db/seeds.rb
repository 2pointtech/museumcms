# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Ticketing::Ticket.delete_all

Ticketing::GeneralTicket.create({ :title => 'General Admission', :price => 5, :child_price => 5, :content => 'General Admission grants access to the Great Hall & Discovery Room' })
Ticketing::GeneralTicket.create({ :title => 'Exhibition Admission', :price => 10, :child_price => 5, :additional_cost => true, :content => 'Exhibition grants access to the American Museum of Natural History\'s Water: H20 = Life Exhibition' })
Ticketing::GeneralTicket.create({ :title => 'Discovery Room', :price => 5, :child_price => 5, :additional_cost => true, :content => 'Grants access to the Discovery Room.  Adults must be accompanined by a child.' })

Ticketing::Membership.create({ :title => 'Individual Membership', :price => 80, :content => 'Various Individual Membership levels available. Ask one of our volunteers or staff about membership benefits!' })
Ticketing::Membership.create({ :title => 'Family Membership', :price => 120, :content => 'Various Family Membership levels available. Ask one of our volunteers or staff about membership benefits!' })
