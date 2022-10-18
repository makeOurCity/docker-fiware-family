.PHONY: build serve shutdown stop

build:
	docker compose up -d postgresql
	./wait-for-docker-compose-postgres.sh
	docker compose run --rm kong kong migrations bootstrap

serve:
	docker compose up -d

stop: shutdown

shutdown:
	docker compose stop
