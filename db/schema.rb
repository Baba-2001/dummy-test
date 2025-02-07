# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_06_071310) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "vector"

  create_table "auth_group", id: :integer, default: nil, force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.index ["name"], name: "auth_group_name_a6ea08ec_like", opclass: :varchar_pattern_ops
    t.unique_constraint ["name"], name: "auth_group_name_key"
  end

  create_table "auth_group_permissions", id: :bigint, default: nil, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "permission_id", null: false
    t.index ["group_id"], name: "auth_group_permissions_group_id_b120cbf9"
    t.index ["permission_id"], name: "auth_group_permissions_permission_id_84c5c92e"
    t.unique_constraint ["group_id", "permission_id"], name: "auth_group_permissions_group_id_permission_id_0cd325b0_uniq"
  end

  create_table "auth_permission", id: :integer, default: nil, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "content_type_id", null: false
    t.string "codename", limit: 100, null: false
    t.index ["content_type_id"], name: "auth_permission_content_type_id_2f476e4b"
    t.unique_constraint ["content_type_id", "codename"], name: "auth_permission_content_type_id_codename_01ab375a_uniq"
  end

  create_table "auth_user", id: :integer, default: nil, force: :cascade do |t|
    t.string "password", limit: 128, null: false
    t.timestamptz "last_login"
    t.boolean "is_superuser", null: false
    t.string "username", limit: 150, null: false
    t.string "first_name", limit: 150, null: false
    t.string "last_name", limit: 150, null: false
    t.string "email", limit: 254, null: false
    t.boolean "is_staff", null: false
    t.boolean "is_active", null: false
    t.timestamptz "date_joined", null: false
    t.index ["username"], name: "auth_user_username_6821ab7c_like", opclass: :varchar_pattern_ops
    t.unique_constraint ["username"], name: "auth_user_username_key"
  end

  create_table "auth_user_groups", id: :bigint, default: nil, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.index ["group_id"], name: "auth_user_groups_group_id_97559544"
    t.index ["user_id"], name: "auth_user_groups_user_id_6a12ed8b"
    t.unique_constraint ["user_id", "group_id"], name: "auth_user_groups_user_id_group_id_94350c0c_uniq"
  end

  create_table "auth_user_user_permissions", id: :bigint, default: nil, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "permission_id", null: false
    t.index ["permission_id"], name: "auth_user_user_permissions_permission_id_1fbb5f2c"
    t.index ["user_id"], name: "auth_user_user_permissions_user_id_a95ead1b"
    t.unique_constraint ["user_id", "permission_id"], name: "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq"
  end

  create_table "chat_agent", id: :bigint, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.string "name", limit: 180, null: false
    t.string "handle", limit: 180, null: false
    t.text "system_prompt"
    t.string "tools", limit: 255, array: true
  end

  create_table "chat_agentfile", id: :bigint, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.string "file", limit: 100, null: false
    t.text "description"
    t.bigint "agent_id", null: false
    t.index ["agent_id"], name: "chat_agentfile_agent_id_af748f2b"
  end

  create_table "chat_agentinvocationlog", id: :bigint, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.text "query", null: false
    t.jsonb "request", null: false
    t.text "response", null: false
    t.bigint "agent_id", null: false
    t.bigint "channelMessage_id"
    t.index ["agent_id"], name: "chat_agentinvocationlog_agent_id_62b0cedf"
    t.index ["channelMessage_id"], name: "chat_agentinvocationlog_channelMessage_id_6392ebd3"
  end

  create_table "chat_channel", id: :bigint, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.string "name", limit: 180, null: false
    t.text "description"
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "chat_channel_organization_id_007bcca4"
  end

  create_table "chat_channel_agent", id: :bigint, default: nil, force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.bigint "agent_id", null: false
    t.index ["agent_id"], name: "chat_channel_agent_agent_id_12d77506"
    t.index ["channel_id"], name: "chat_channel_agent_channel_id_6e9548e4"
    t.unique_constraint ["channel_id", "agent_id"], name: "chat_channel_agent_channel_id_agent_id_c9665c3b_uniq"
  end

  create_table "chat_channel_user", id: :bigint, default: nil, force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.bigint "user_id", null: false
    t.index ["channel_id"], name: "chat_channel_user_channel_id_42b94686"
    t.index ["user_id"], name: "chat_channel_user_user_id_2775c55a"
    t.unique_constraint ["channel_id", "user_id"], name: "chat_channel_user_channel_id_user_id_d206c4a4_uniq"
  end

  create_table "chat_channelmessage", id: :bigint, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.text "message", null: false
    t.string "timestamp", limit: 180, null: false
    t.string "role", limit: 180, null: false
    t.bigint "agent_id"
    t.bigint "channel_id", null: false
    t.bigint "user_id"
    t.index ["agent_id"], name: "chat_channelmessage_agent_id_a8f96a7f"
    t.index ["channel_id"], name: "chat_channelmessage_channel_id_e1261167"
    t.index ["user_id"], name: "chat_channelmessage_user_id_dabb578b"
  end

  create_table "chat_organization", id: :bigint, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.string "name", limit: 180, null: false
    t.text "openai_key", null: false
    t.string "domain", limit: 180
    t.index ["domain"], name: "chat_organization_domain_08695d2d_like", opclass: :varchar_pattern_ops
    t.unique_constraint ["domain"], name: "chat_organization_domain_key"
  end

  create_table "chat_user", id: :bigint, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.string "name", limit: 180, null: false
    t.string "email", limit: 254, null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "chat_user_organization_id_dbf6cc0a"
  end

# Could not dump table "data_embeddings" because of following StandardError
#   Unknown type 'vector(1536)' for column 'embedding'


  create_table "django_admin_log", id: :integer, default: nil, force: :cascade do |t|
    t.timestamptz "action_time", null: false
    t.text "object_id"
    t.string "object_repr", limit: 200, null: false
    t.integer "action_flag", limit: 2, null: false
    t.text "change_message", null: false
    t.integer "content_type_id"
    t.integer "user_id", null: false
    t.index ["content_type_id"], name: "django_admin_log_content_type_id_c4bce8eb"
    t.index ["user_id"], name: "django_admin_log_user_id_c564eba6"
    t.check_constraint "action_flag >= 0", name: "django_admin_log_action_flag_check"
  end

  create_table "django_content_type", id: :integer, default: nil, force: :cascade do |t|
    t.string "app_label", limit: 100, null: false
    t.string "model", limit: 100, null: false

    t.unique_constraint ["app_label", "model"], name: "django_content_type_app_label_model_76bd3d3b_uniq"
  end

  create_table "django_migrations", id: :bigint, default: nil, force: :cascade do |t|
    t.string "app", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.timestamptz "applied", null: false
  end

  create_table "django_session", primary_key: "session_key", id: { type: :string, limit: 40 }, force: :cascade do |t|
    t.text "session_data", null: false
    t.timestamptz "expire_date", null: false
    t.index ["expire_date"], name: "django_session_expire_date_a5c62663"
    t.index ["session_key"], name: "django_session_session_key_c0390e0f_like", opclass: :varchar_pattern_ops
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
  end

  add_foreign_key "auth_group_permissions", "auth_group", column: "group_id", name: "auth_group_permissions_group_id_b120cbf9_fk_auth_group_id", deferrable: :deferred
  add_foreign_key "auth_group_permissions", "auth_permission", column: "permission_id", name: "auth_group_permissio_permission_id_84c5c92e_fk_auth_perm", deferrable: :deferred
  add_foreign_key "auth_permission", "django_content_type", column: "content_type_id", name: "auth_permission_content_type_id_2f476e4b_fk_django_co", deferrable: :deferred
  add_foreign_key "auth_user_groups", "auth_group", column: "group_id", name: "auth_user_groups_group_id_97559544_fk_auth_group_id", deferrable: :deferred
  add_foreign_key "auth_user_groups", "auth_user", column: "user_id", name: "auth_user_groups_user_id_6a12ed8b_fk_auth_user_id", deferrable: :deferred
  add_foreign_key "auth_user_user_permissions", "auth_permission", column: "permission_id", name: "auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm", deferrable: :deferred
  add_foreign_key "auth_user_user_permissions", "auth_user", column: "user_id", name: "auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id", deferrable: :deferred
  add_foreign_key "chat_agentfile", "chat_agent", column: "agent_id", name: "chat_agentfile_agent_id_af748f2b_fk_chat_agent_id", deferrable: :deferred
  add_foreign_key "chat_agentinvocationlog", "chat_agent", column: "agent_id", name: "chat_agentinvocationlog_agent_id_62b0cedf_fk_chat_agent_id", deferrable: :deferred
  add_foreign_key "chat_agentinvocationlog", "chat_channelmessage", column: "channelMessage_id", name: "chat_agentinvocation_channelMessage_id_6392ebd3_fk_chat_chan", deferrable: :deferred
  add_foreign_key "chat_channel", "chat_organization", column: "organization_id", name: "chat_channel_organization_id_007bcca4_fk_chat_organization_id", deferrable: :deferred
  add_foreign_key "chat_channel_agent", "chat_agent", column: "agent_id", name: "chat_channel_agent_agent_id_12d77506_fk_chat_agent_id", deferrable: :deferred
  add_foreign_key "chat_channel_agent", "chat_channel", column: "channel_id", name: "chat_channel_agent_channel_id_6e9548e4_fk_chat_channel_id", deferrable: :deferred
  add_foreign_key "chat_channel_user", "chat_channel", column: "channel_id", name: "chat_channel_user_channel_id_42b94686_fk_chat_channel_id", deferrable: :deferred
  add_foreign_key "chat_channel_user", "chat_user", column: "user_id", name: "chat_channel_user_user_id_2775c55a_fk_chat_user_id", deferrable: :deferred
  add_foreign_key "chat_channelmessage", "chat_agent", column: "agent_id", name: "chat_channelmessage_agent_id_a8f96a7f_fk_chat_agent_id", deferrable: :deferred
  add_foreign_key "chat_channelmessage", "chat_channel", column: "channel_id", name: "chat_channelmessage_channel_id_e1261167_fk_chat_channel_id", deferrable: :deferred
  add_foreign_key "chat_channelmessage", "chat_user", column: "user_id", name: "chat_channelmessage_user_id_dabb578b_fk_chat_user_id", deferrable: :deferred
  add_foreign_key "chat_user", "chat_organization", column: "organization_id", name: "chat_user_organization_id_dbf6cc0a_fk_chat_organization_id", deferrable: :deferred
  add_foreign_key "django_admin_log", "auth_user", column: "user_id", name: "django_admin_log_user_id_c564eba6_fk_auth_user_id", deferrable: :deferred
  add_foreign_key "django_admin_log", "django_content_type", column: "content_type_id", name: "django_admin_log_content_type_id_c4bce8eb_fk_django_co", deferrable: :deferred
end
