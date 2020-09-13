defimpl Canada.Can, for: QaDashboard.Accounts.User do
  @moduledoc """
    Permissions for dashboard,
    for right this instance, all is true
  """
  import Canada, only: [can?: 2]

  require Logger

  @doc """
    All users outside of auth/not auth can do anything
  """
  def can?(user, action, opts) do
    Logger.debug(
      "USER_DEFAULT_AUTHORIZATION: #{user.email} id: #{user.id} was allowed default action #{
        inspect(action)
      } on #{inspect(opts)}"
    )

    true
  end
end
