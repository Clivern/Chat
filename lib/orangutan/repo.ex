# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Orangutan.Repo do
  use Ecto.Repo,
    otp_app: :orangutan,
    adapter: Ecto.Adapters.Postgres

  # adapter: Ecto.Adapters.SQLite3
end
