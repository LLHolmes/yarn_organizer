To Do:
Project edit --> finished --> updates and moves yarn to stash
Clean up layout & flow (adjust user home/index?):
  Once logged in, shows welcome with master index of things individual user can do?:
 - start a new project / add a new yarn/accessory
 - find my project/yarn/accessory
Try to break it / test everything:
 - Double check current_user == @project.user validations, etc.
CSS if possible



# App Overview
  -- An app to help organize one's yarn stash, crafting accessories, and project usage and plans.
# Users will need to:
  [x] Log in, sign up, and log out.
# Users will be able to:
  [x] Create a new project.
  [x] Add yarn to their stash. - Add a new brand if necessary, or associate it with an existing brand.
  [x] Add accessories to their horde.
  [x] See their projects.
  [x] See a list of their entire yarns stash.
  [x] Explore their brands.
  [x] See a list of their accessories.
  [x] Edit projects.
  [x] Edit yarn.
  [x] Edit brands.
  [x] Edit accessories.
  [x] Delete projects.
  [x] Delete yarns.
  [x] Delete brands.
  [x] Delete accessories.
# Wireframing
  -- Models: User, Project, Yarn, Brand, Accessories
  -- User: name, email (for unique login), password (password_digest in database)
  -- Rest on paper...
# Stretch goals
  [ ] CSS
  [ ] sluggify?
  [ ] link to patterns / images etc.
  [ ] write a pattern???
  [ ] add hobbies to users???
  [ ] add color_family to yarns?
  [ ] add location/where_to_find to projects???
  [ ] add laundering instructions to brand?
  [ ] public vs. private??? -->
  [ ] add a trading post.
  [ ] add this project to my project list.
  [ ] create index of all projects for inspiration?





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
- [x] Include user accounts with unique login attribute (username or email)
    -- Checks for unique email
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
    -- Lots of routes for all belongs_to resources
- [x] Ensure that users can't modify content created by other users
    -- Lots of safeguards for all models
- [x] Include user input validations
    -- Lots of validations
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
    -- Flash messages added
- [.] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
    -- Need to add Usage instructions!

Confirm:
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [.] You don't include changes in a commit that aren't related to the commit message
