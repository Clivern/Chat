# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Orangutan.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :age, :integer
    field :country, :string
    field :email, :string
    field :gender, :string
    field :last_seen, :utc_datetime
    field :name, :string
    field :password_hash, :string
    field :state, :string
    field :username, :string
    field :verified, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :username,
      :email,
      :password_hash,
      :verified,
      :gender,
      :country,
      :state,
      :age,
      :last_seen
    ])
    |> validate_required([
      :name,
      :username,
      :email,
      :password_hash,
      :verified,
      :gender,
      :country,
      :state,
      :age,
      :last_seen
    ])
  end
end
