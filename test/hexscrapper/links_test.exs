defmodule Hexscrapper.LinksTest do
  use Hexscrapper.DataCase

  alias Hexscrapper.Links

  describe "links" do
    alias Hexscrapper.Links.Link

    import Hexscrapper.LinksFixtures

    @invalid_attrs %{name: nil, href: nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Links.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Links.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{name: "some name", href: "some href"}

      assert {:ok, %Link{} = link} = Links.create_link(valid_attrs)
      assert link.name == "some name"
      assert link.href == "some href"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      update_attrs = %{name: "some updated name", href: "some updated href"}

      assert {:ok, %Link{} = link} = Links.update_link(link, update_attrs)
      assert link.name == "some updated name"
      assert link.href == "some updated href"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_link(link, @invalid_attrs)
      assert link == Links.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Links.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Links.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Links.change_link(link)
    end
  end
end
