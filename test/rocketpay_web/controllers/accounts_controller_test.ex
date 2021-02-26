defmodule RocketpayWeb.AccountsControllerTest do

    use RocketpayWeb.ConnCase, async: true
    alias Rocketpay.{User, Account}
    describe "deposit/2"do
      setup %{conn: conn} do
        params = %{
          name: "Saulo",
          password_hash: "123456",
          nickname: "gelts"
          email: "saulo@mail.com",
          age: 27
        }

        {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

        conn = put_req_header(conn, "authorization", "Basic Z2VsdHM6MTIzNDU2")

        {:ok, conn: conn, account_id: account_id}
      end

      test "when all params are valid, make an deposit", %{conn: conn, account_id: account_id} do
        params = %{"value" => "50.00"}

        response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params)
        |> json_response(:ok)

        assert response = %{
          "message" => "Balance chaged successfully",
            "account" => %{
              "id" =>  _id,
              "balance" => "50.00"
            }
        }
      end

      test "when there are invalid, returns a error", %{conn: conn, account_id: account_id} do
        params = %{"value" => "banana"}

        response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params)
        |> json_response(:bad_request)

        expected_response = %{
          "message" => "Invalid deposit value!"
        }
        assert response == expected_response
      end

    end
end
