.PHONY: build serve shutdown stop clean

build:
	docker compose up -d postgresql
	./wait-for-docker-compose-postgres.sh
	docker compose run --rm kong kong migrations bootstrap

serve:
	docker compose up -d

services:
	 docker compose up -d mongo-express orion sth-comet cygnus

stop: shutdown

shutdown:
	docker compose stop

clean:
	docker compose down -v
	rm -rf ./data/*
