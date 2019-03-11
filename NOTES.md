post '/pirates' do
  # binding.pry
  pirate = Pirate.new(name: params[:pirate][:name], height: params[:pirate][:height], weight: params[:pirate][:weight])
  params[:pirate][:ships].each do |ship_data|
    ship = Ship.new(ship_data)
    ship.pirate = pirates
    ship.save
  end
  binding.pry
end

* set up an if statement that if pirate.save: do what you want, as a way to make sure the pirate saves. *


# App Overview
  -- An app to help organize one's yarn stash, crafting accessories, and project usage and plans.
# Users will need to:
  [ ] Log in, sign up, and log out.
# Users will be able to:
  [ ] Create a new project.
  [ ] Add yarn to their stash. - Add a new brand if necessary, or associate it with an existing brand.
  [ ] Add accessories to their horde.
  [ ] See all projects.
  [ ] See a list of their entire yarns stash.
  [ ] Explore their brands.
  [ ] See a list of their accessories.
  [ ] Edit projects.
  [ ] Edit yarn.
  [ ] Edit brands.
  [ ] Edit accessories.
  [ ] Delete projects.
  [ ] Delete yarns.
  [ ] Delete brands.
  [ ] Delete accessories.
# Wireframing
  -- Models: User, Project, Yarn, Brand, Accessories
  -- User: name, email (for unique login), password (password_digest in database)
  -- Rest on paper...
# Stretch goals
  [ ] CSS
  [ ] Tests?
  [ ] link to patterns / images etc.
  [ ] write a pattern???
  [ ] add hobbies to users?
  [ ] add color_family to yarns?
  [ ] add location/where_to_find to projects?
  [ ] add laundering instructions to brand?
  [ ] public vs. private??? -->
  [ ] add a trading post.

Add pattern url option to Projects table.
Index sends you to log in if not already logged in.
Log in has link to sign up (Join the community). - Either sends you to your index.
Once logged in, shows welcome with master index of things individual user can do:
 - start a new project / add a new yarn/accessory
 - find my project/yarn/accessory


Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
    -- I am using Sinatra as the basis for my app.
- [x] Use ActiveRecord for storing information in a database
    -- My databases depend on ActiveRecord.
- [x] Include more than one model class (e.g. User, Post, Category)
    -- I have 5 categories.
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    -- Many, but: A User has_many Projects, Yarns, Accessories, and Brands
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
    -- Many, but: Yarns belongs_to a Project and a Brand
- [ ] Include user accounts with unique login attribute (username or email)
- [ ] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
- [ ] Ensure that users can't modify content created by other users
- [ ] Include user input validations
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [.] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
    -- Need to add Usage instructions!

Confirm:
- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message
- [ ] You don't include changes in a commit that aren't related to the commit message
