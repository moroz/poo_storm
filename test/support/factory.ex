defmodule PooStorm.Factory do
  use ExMachina.Ecto, repo: PooStorm.Repo

  def comment_factory do
    %PooStorm.Comments.Comment{
      signature: "joe",
      body: "Test test",
      email: "user@example.com",
      url: "http://moroz.dev",
      remote_ip: "8.8.8.8"
    }
  end
end
