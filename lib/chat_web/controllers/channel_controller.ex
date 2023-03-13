# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule ChatWeb.ChannelController do
  use ChatWeb, :controller

  def list(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, "{\"status\": \"ok\"}")
  end

  def create(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, "{\"status\": \"ok\"}")
  end

  def index(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, "{\"status\": \"ok\"}")
  end

  def update(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, "{\"status\": \"ok\"}")
  end

  def delete(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, "{\"status\": \"ok\"}")
  end
end
