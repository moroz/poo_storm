# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PooStorm.Repo.insert!(%PooStorm.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PooStorm.Repo
alias PooStorm.Comments.Comment

Repo.delete_all(Comment)

Repo.insert!(%Comment{
  body: "Karmapa chenno",
  remote_ip: %Postgrex.INET{address: {127, 0, 0, 1}},
  signature: "Test signature",
  url: "/blog/the-manifesto",
  email: "user@example.com",
  website: "https://moroz.dev"
})
