defmodule Rocketpay.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rocketpay.Account
  alias Ecto.Changeset

  @primary_key{:id, :binary_id, autogenerate: true}

  @required_params [:name, :age, :email, :password_hash, :nickname]

  schema "users" do
      field :name, :string
      field :age, :integer
      field :email, :string
      field :password_hash, :string
      field :nickname, :string
      has_one :account, Account

      timestamps()
  end


  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password_hash, min: 6)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
  end


end
