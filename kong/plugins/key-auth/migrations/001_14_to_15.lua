return {
  postgres = {
    up = [[
      ALTER TABLE IF EXISTS ONLY "keyauth_credentials"
        ALTER "created_at" TYPE TIMESTAMP WITH TIME ZONE USING "created_at" AT TIME ZONE 'UTC',
        ALTER "created_at" SET DEFAULT CURRENT_TIMESTAMP(0) AT TIME ZONE 'UTC';

      ALTER INDEX IF EXISTS "keyauth_consumer_idx" RENAME TO "keyauth_credentials_consumer_id_idx";

      -- Unique constraint on "key" already adds btree index
      DROP INDEX IF EXISTS "keyauth_key_idx";
    ]],
  },

  cassandra = {
    up = [[
      BEGIN BATCH
        -- nothing to migrate
      APPLY BATCH;
    ]],
  },
}
