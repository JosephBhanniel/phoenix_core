defmodule PhoenixCoreWeb.Router do
  use PhoenixCoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PhoenixCoreWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixCoreWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/modules", PageController, :modules
    get "/landing/pages", PageController, :modules

    live "/tbl_modules", ModuleLive.Index, :index
    live "/tbl_modules/new", ModuleLive.Index, :new
    live "/tbl_modules/:id/edit", ModuleLive.Index, :edit

    live "/tbl_modules/:id", ModuleLive.Show, :show
    live "/tbl_modules/:id/show/edit", ModuleLive.Show, :edit

  end

  scope "/forms", PhoenixCoreWeb.Form1Live do
    pipe_through :browser

    live "/form1", Index, :index
    live "/form1/new", Index, :new
    live "/form1/:id/edit", Index, :edit

    live "/form1/:id", Show, :show
    live "/form1/:id/show/edit", Show, :edit
    live "/wizard1", Wizard
  end
  # Other scopes may use custom stacks.
  # scope "/api", PhoenixCoreWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:phoenix_core, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhoenixCoreWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
