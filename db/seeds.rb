# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

lorem = <<~LOREM
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed nunc nisl. Curabitur luctus facilisis interdum. Nulla molestie placerat ipsum, at hendrerit tortor hendrerit nec. Mauris in diam eget diam suscipit commodo ut ac dolor. Praesent ultrices sed quam quis aliquam. Vivamus iaculis enim eu placerat consectetur. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec libero erat, viverra id aliquet et, porta facilisis lorem. Donec metus odio, dictum eget placerat ut, placerat id elit. Nulla facilisi. Morbi quis dignissim odio. Vivamus vel dictum ligula. Donec congue risus convallis, dictum urna vitae, tincidunt quam. Duis a viverra ex. Sed sit amet metus at justo imperdiet pulvinar.

In orci leo, tristique tincidunt enim eget, vestibulum accumsan mi. Maecenas viverra felis et ipsum condimentum pellentesque. Curabitur varius rhoncus semper. Fusce lobortis tristique augue nec tristique. Donec rhoncus, justo eget dignissim rhoncus, ante dui cursus nulla, vitae elementum mi urna eu metus. Phasellus laoreet, lectus non volutpat sollicitudin, purus odio fermentum lorem, a posuere ipsum nulla in sapien. Aliquam quis justo ac velit sollicitudin vestibulum.

Vestibulum nec justo justo. Duis tristique ullamcorper ex a tristique. Duis et nisl sit amet elit venenatis scelerisque id sed tortor. Nulla bibendum ornare ante, a porttitor odio sollicitudin eget. Aliquam erat volutpat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nunc non tincidunt ex, sit amet tempor lectus. Cras eget nunc vel augue vestibulum mattis.

Donec lacus lectus, convallis luctus dui a, rutrum accumsan magna. Cras placerat erat quis quam dictum lacinia nec vel lorem. Aenean a nisl justo. Vivamus diam urna, dapibus in velit eget, pharetra tempus felis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Integer blandit odio a purus bibendum, vestibulum consectetur lacus facilisis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Morbi euismod nulla lobortis, vulputate urna vel, rhoncus ligula. Sed non tempor nunc. Nunc erat diam, rutrum id porta non, cursus a leo.

Praesent suscipit risus sapien, vel tincidunt massa lobortis a. Pellentesque dictum elit sit amet nulla molestie tincidunt. Vivamus facilisis urna et pellentesque tristique. Aenean id lorem finibus, porttitor sapien elementum, viverra libero. Duis semper pharetra ex auctor efficitur. Pellentesque malesuada scelerisque tellus ac elementum. Duis magna est, iaculis sit amet quam a, porttitor venenatis ex. Curabitur congue consequat lacinia. Donec lobortis ultricies magna, interdum rhoncus justo pulvinar sit amet. Nam mattis, lectus eget tempus viverra, quam odio tempus dui, non ultrices justo libero ut mi. Cras eget imperdiet enim. In hac habitasse platea dictumst. Donec vitae elit in quam facilisis posuere sollicitudin eget orci. Vivamus ipsum mauris, congue et purus vitae, posuere rutrum dui.
LOREM

lorem_summary = <<~LOREM
"Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."
"There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."
LOREM

Tag.create_or_find_by!(name: 'Untagged', permalink: 'untagged')

if ENV['RAILS_ENV'] == 'development'
  admin = User.find_by_email('admin@test.com')

  if admin.nil?
    admin = User.create_or_find_by(
      name:                  'Admin',
      email:                 'admin@test.com',
      password:              '123456',
	  password_confirmation: '123456',
	  role:                  'admin'
    )
    admin.confirm
  end

  Post.create(title: "Lorem Ipsum", user: admin, content: lorem, summary: lorem_summary)
end

