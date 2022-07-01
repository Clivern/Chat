# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

# Room Context Module
defmodule Orangutan.Context.RoomContext do
  import Ecto.Query
  alias Orangutan.Repo
  alias Orangutan.Model.{RoomMeta, Room}

  # Get a room map
  def new_room(room \\ %{}) do
    %{
      icon: room.icon,
      country: room.country,
      is_private: room.is_private,
      slug: room.slug,
      state: room.state,
      name: room.name,
      uuid: Ecto.UUID.generate(),
      user_id: room.user_id,
      client_id: room.client_id
    }
  end

  # Get a room meta map
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      room_id: meta.room_id
    }
  end

  # Create a new room
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  # Count all rooms
  def count_rooms(country, state, is_private) do
    case {country, state} do
      {country, state} when country != "" and state != "" ->
        from(u in Room,
          select: count(u.id),
          where: u.country == ^country,
          where: u.state == ^state,
          where: u.is_private == ^is_private
        )
        |> Repo.one()

      {country, state} when country == "" and state == "" ->
        from(u in Room,
          select: count(u.id),
          where: u.is_private == ^is_private
        )
        |> Repo.one()

      {country, state} when country != "" and state == "" ->
        from(u in Room,
          select: count(u.id),
          where: u.country == ^country,
          where: u.is_private == ^is_private
        )
        |> Repo.one()

      {country, state} when country == "" and state != "" ->
        from(u in Room,
          select: count(u.id),
          where: u.state == ^state,
          where: u.is_private == ^is_private
        )
        |> Repo.one()
    end
  end

  # Retrieve a room by ID
  def get_room_by_id(id) do
    Repo.get(Room, id)
  end

  # Get room by slug
  def get_room_by_slug(slug) do
    from(
      u in Room,
      where: u.slug == ^slug
    )
    |> Repo.one()
  end

  # Get room by name
  def get_room_by_name(name) do
    from(
      u in Room,
      where: u.name == ^name
    )
    |> Repo.one()
  end

  # Update a room
  def update_room(room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  # Delete a room
  def delete_room(room) do
    Repo.delete(room)
  end

  # Retrieve all rooms
  def get_rooms() do
    Repo.all(Room)
  end

  # Retrieve rooms
  def get_rooms(country, state, is_private, offset, limit) do
    case {country, state, offset, limit} do
      {country, state, offset, limit} when country != "" and state != "" ->
        from(u in Room,
          where: u.country == ^country,
          where: u.state == ^state,
          where: u.is_private == ^is_private,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()

      {country, state, offset, limit} when country == "" and state == "" ->
        from(u in Room,
          where: u.is_private == ^is_private,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()

      {country, state, offset, limit} when country != "" and state == "" ->
        from(u in Room,
          where: u.is_private == ^is_private,
          where: u.country == ^country,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()

      {country, state, offset, limit} when country == "" and state != "" ->
        from(u in Room,
          where: u.is_private == ^is_private,
          where: u.state == ^state,
          limit: ^limit,
          offset: ^offset
        )
        |> Repo.all()
    end
  end

  # Create a new room meta attribute
  def create_room_meta(attrs \\ %{}) do
    %RoomMeta{}
    |> RoomMeta.changeset(attrs)
    |> Repo.insert()
  end

  # Retrieve a room meta attribute by ID
  def get_room_meta_by_id(id) do
    Repo.get(RoomMeta, id)
  end

  # Update a room meta attribute
  def update_room_meta(room_meta, attrs) do
    changeset = RoomMeta.changeset(room_meta, attrs)
    Repo.update(changeset)
  end

  # Delete a room meta attribute
  def delete_room_meta(room_meta) do
    Repo.delete(room_meta)
  end

  # Validate a room password
  def validate_password(plain_password, hash) do
    Argon2.verify_pass(plain_password, hash)
  end

  # Get room meta by room and key
  def get_room_meta_by_key(room_id, meta_key) do
    from(
      u in RoomMeta,
      where: u.room_id == ^room_id,
      where: u.key == ^meta_key
    )
    |> Repo.one()
  end

  # Get room metas
  def get_room_metas(room_id) do
    from(
      u in RoomMeta,
      where: u.room_id == ^room_id
    )
    |> Repo.all()
  end
end
