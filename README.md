## Fork of [docker-postgres-wale](https://github.com/lukesmith/docker-postgres-wale)

# Postgres docker container with wale

Based on https://github.com/docker-library/postgres with [WAL-E](https://github.com/wal-e/wal-e) installed.

Environment variables to pass to the container for WAL-E, all of these must be present or WAL-E is not configured.

`docker pull andrewgy8/docker-wale-azure`

```
WALE_WABS_PREFIX="wabs://<bucketname>/<path>"
WABS_ACCOUNT_NAME
WABS_ACCESS_KEY
WABS_SAS_TOKEN (optional)
```

## Running

The master

```
docker run -it \
  --env "WABS_ACCOUNT_NAME=****" \
  --env "WABS_ACCESS_KEY=****" \
  --env "WALE_WABS_PREFIX=wabs://my-bucket" \
  --env "POSTGRES_AUTHORITY=master" \
  -v ./data/master:/var/lib/postgresql/data \
  docker-postgres-azure
```

The slave will run in `standby_mode`.

```
docker run -it \
  --env "WABS_ACCOUNT_NAME=****" \
  --env "WABS_ACCESS_KEY=****" \
  --env "WALE_WABS_PREFIX=wabs://my-bucket" \
  --env "POSTGRES_AUTHORITY=slave" \
  -v ./data/slave:/var/lib/postgresql/data \
  docker-postgres-azure
```

When bringing online `rm ./data/recovery.conf` and start the container with `POSTGRES_AUTHORITY=master`.
