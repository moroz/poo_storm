defmodule PooStorm.CommentsTest do
  use PooStorm.DataCase

  alias PooStorm.Comments

  def comment_fixture(attrs \\ %{}) do
    insert(:comment, attrs)
  end

  describe "comments" do
    alias PooStorm.Comments.Comment

    @invalid_attrs %{body: nil, remote_ip: nil, signature: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Comments.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Comments.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = params_for(:comment, remote_ip: "127.0.0.1")

      assert {:ok, %Comment{} = comment} = Comments.create_comment(valid_attrs)
      assert comment.body == valid_attrs.body
      assert %Postgrex.INET{address: {127, 0, 0, 1}} = comment.remote_ip
      assert comment.signature == valid_attrs.signature
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comments.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()

      update_attrs = %{
        body: "some updated body",
        remote_ip: "8.8.8.8",
        signature: "some updated signature"
      }

      assert {:ok, %Comment{} = comment} = Comments.update_comment(comment, update_attrs)
      assert comment.body == "some updated body"
      assert %Postgrex.INET{address: {8, 8, 8, 8}} = comment.remote_ip
      assert comment.signature == "some updated signature"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Comments.update_comment(comment, @invalid_attrs)
      assert comment == Comments.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Comments.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Comments.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Comments.change_comment(comment)
    end
  end
end
