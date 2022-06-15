# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule ChatWeb.Router do
  use ChatWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ChatWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :pub do
    plug :accepts, ["json"]
  end

  scope "/", ChatWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", ChatWeb do
    pipe_through :pub

    get "/_health", HealthController, :health
    get "/_ready", ReadyController, :ready
  end

  scope "/api/v1", ChatWeb do
    pipe_through :api

    get "/user", UserController, :list
    post "/user", UserController, :create
    get "/user/:id", UserController, :index
    put "/user/:id", UserController, :update
    delete "/user/:id", UserController, :delete

    get "/client", ClientController, :list
    post "/client", ClientController, :create
    get "/client/:id", ClientController, :index
    put "/client/:id", ClientController, :update
    delete "/client/:id", ClientController, :delete

    get "/channel", ChannelController, :list
    post "/channel", ChannelController, :create
    get "/channel/:id", ChannelController, :index
    put "/channel/:id", ChannelController, :update
    delete "/channel/:id", ChannelController, :delete
  end

  scope "/action/v1", ChatWeb do
    pipe_through :api
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ChatWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end