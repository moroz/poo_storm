defmodule PooStorm.Factory do
  use ExMachina.Ecto, repo: PooStorm.Repo

  def comment_factory do
    %PooStorm.Comments.Comment{
      signature: "Yo it's me",
      body: "Test test",
      email: "user@example.com",
      url: "http://moroz.dev"
    }
  end
end
