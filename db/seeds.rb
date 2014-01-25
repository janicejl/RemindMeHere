# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Item.delete_all

file = File.open("#{Rails.root}/db/seed_data/categories.txt");

file.read.each_line do |line|
  name, category = line.chomp.downcase.split("|")
  name.strip!
  category.strip!

  Item.find_or_create_by_name(:name => name, :category => category);
end