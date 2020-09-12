# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     QaDashboard.Repo.insert!(%QaDashboard.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
{:ok, super_admin_role} = QaDashboard.Permissions.create_role(%{name: "super_admin"})
{:ok, admin_role}= QaDashboard.Permissions.create_role(%{name: "admin"})
{:ok, user_role} = QaDashboard.Permissions.create_role(%{name: "user"})


super_admin_user = QaDashboard.Accounts.register_user(%{email: "superadmin@admin.com", password: "abcdef123456", role_id: super_admin_role.id})
admin_user = QaDashboard.Accounts.register_user(%{email: "admin@admin.com", password: "abcdef123456", role_id: admin_role.id})
user = QaDashboard.Accounts.register_user(%{email: "user@admin.com", password: "abcdef123456", role_id: user_role.id})