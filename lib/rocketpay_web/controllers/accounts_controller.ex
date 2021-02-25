defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Account

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <-  Rocketpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.jason", account: account)
    end
  end

  def withdraw(conn, params) do

  end

end
