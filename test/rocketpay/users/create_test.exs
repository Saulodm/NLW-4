defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.{Repo, User}
  alias Rocketpay.Users.Create


  describe "call/1" do
    test "when all params as valid, returns an user" do
      params = %{
        name: "Saulo",
        password_hash: "123456",
        nickname: "gelts"
        email: "saulo@mail.com",
        age: 27
      }

      {:ok, %User{id: user_id} = Create.call(params)}
      user = Repo.get(User, user_id)

      assert %User{name: "Saulo", age: 27, id: ^user_id} = user
    end

    test "when there are invalid params, returns a error" do
      params = %{
        name: "Saulo",
        nickname: "gelts"
        email: "saulo@mail.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)
      expected_response = %{
        age: ["must be grater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert  erros_on(changest) == expected_response
    end
  end
end
