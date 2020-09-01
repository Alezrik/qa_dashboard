defmodule QaDashboard.Accounts.UserIngestToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_ingest_tokens" do
    field :name, :string
    field :token, :binary
    field :type, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_ingest_token, attrs) do
    user_ingest_token
    |> cast(attrs, [:token, :name, :type])
    |> validate_required([:token, :name, :type])
  end
end
