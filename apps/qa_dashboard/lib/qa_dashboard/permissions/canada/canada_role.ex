defimpl Canada.Can, for: QaDashboard.Permissions.Role do
  @moduledoc """
    Permissions for dashboard,
    for right this instance, all is true
  """

  require Logger

  @doc """
    All users outside of auth/not auth can do anything
  """
  def can?(user, action, opts) do
    Logger.warn(
      "DEFAULT_AUTHORIZATION: #{user.email} id: #{user.id} was allowed default action #{
        inspect(action)
      } on #{inspect(opts)}"
    )

    true
  end
end
