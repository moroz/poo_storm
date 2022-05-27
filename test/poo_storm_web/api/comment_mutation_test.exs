defmodule PooStormWeb.Api.CommentMutationTest do
  use PooStormWeb.ApiCase

  alias PooStorm.Comments.Comment

  @mutation """
  fragment CommentDetails on Comment {
    id
    remoteIp
    body
    signature
    url
    website
    insertedAt
  }

  mutation CreateComment($input: CommentInput!) {
    createComment(input: $input) {
      success
      errors
      data {
        ...CommentDetails
      }
    }
  }
  """

  def api_params(attrs \\ %{}) do
    params_for(:comment, attrs) |> Map.delete(:remote_ip)
  end

  describe "createComment mutation" do
    test "returns an error and does not create comment when i_am_a_robot is true" do
      assert Repo.count(Comment) == 0

      params = api_params()
      vars = %{input: Map.put(params, :i_am_a_robot, true)}

      %{"createComment" => %{"success" => false, "errors" => %{"message" => msg}}} =
        mutate(@mutation, vars)

      assert msg =~ ~r/human/i

      assert Repo.count(Comment) == 0
    end

    test "returns success and creates a comment for valid params" do
      assert Repo.count(Comment) == 0

      params = api_params(url: "/test")
      vars = %{input: params}

      %{"createComment" => %{"success" => true, "errors" => nil, "data" => actual}} =
        mutate(@mutation, vars)

      assert actual["url"] == "/test"
      assert actual["body"] =~ params.body
      assert actual["signature"] == params.signature

      assert Repo.count(Comment) == 1
    end

    test "returns error and does not create comment with invalid params" do
      params = api_params(url: "/test", signature: "", email: "user@invalid")
      vars = %{input: params}

      %{"createComment" => %{"success" => false, "errors" => errors, "data" => nil}} =
        mutate(@mutation, vars)

      assert [email_error] = errors["email"]
      assert email_error =~ ~r/valid/i
      assert [signature_error] = errors["signature"]
      assert signature_error =~ ~r/can't be blank/i
    end
  end
end
