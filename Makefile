.PHONY: build serve shutdown stop

build:
	docker compose up -d postgresql
	docker compose run --rm kong kong migrations bootstrap

serve:
	docker compose up -d

stop: shutdown

shutdown:
	docker compose stop
