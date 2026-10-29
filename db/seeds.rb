# Users
alice = User.find_or_create_by!(email: "alice@example.com") { |u| u.name = "Alice Johnson" }
bob   = User.find_or_create_by!(email: "bob@example.com")   { |u| u.name = "Bob Smith" }
carol = User.find_or_create_by!(email: "carol@example.com") { |u| u.name = "Carol White" }

# Teams
engineering = Team.find_or_create_by!(name: "Engineering")
design      = Team.find_or_create_by!(name: "Design")

# Memberships
TeamMembership.find_or_create_by!(user: alice, team: engineering) { |m| m.role = "admin" }
TeamMembership.find_or_create_by!(user: bob,   team: engineering) { |m| m.role = "member" }
TeamMembership.find_or_create_by!(user: carol, team: design)      { |m| m.role = "admin" }
TeamMembership.find_or_create_by!(user: alice, team: design)      { |m| m.role = "member" }

# Notes
Note.find_or_create_by!(title: "Sprint Planning", team: engineering, created_by_user: alice) do |n|
  n.content = "Goals for this sprint: finish auth, deploy staging."
end
Note.find_or_create_by!(title: "API Design", team: engineering, created_by_user: bob) do |n|
  n.content = "REST endpoints agreed upon. See Notion doc for details."
end
Note.find_or_create_by!(title: "Design System Kickoff", team: design, created_by_user: carol) do |n|
  n.content = "Establishing color tokens and component library structure."
end