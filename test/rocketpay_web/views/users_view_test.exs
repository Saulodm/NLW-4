defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View
  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView
  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders create.json" do
    params = %{
      name: "Saulo",
      password_hash: "123456",
      nickname: "gelts"
      email: "saulo@mail.com",
      age: 27
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id} = user} =
       Rocketpay.create_user(params)}

    response =  render(UsersView, "create.json", user: user)
    expected_response = %{
      message: "User created",
      user: %{
        id: user_id,
        name: "Saulo",
        nickname: "gelts",
        account: %{
          id: account_id,
          balance: Decimal.new("0.00")
        }
      }
    }
    assert expected_response == response
  end

  test "renders 500.json" do
    assert render(RocketpayWeb.ErrorView, "500.json", []) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
