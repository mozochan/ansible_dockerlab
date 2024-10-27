.PHONY: build_control
build_control:
	@docker compose build control-node

.PHONY: build_target
build_target: build_control
	@docker compose build target-node1

.PHONY: up
up: build_target
	@docker compose up -d

.PHONY: ps
ps:
	@docker compose ps -a

.PHONY: stop
stop:
	@docker compose stop

.PHONY: down
down:
	@docker compose down

.PHONY: con
con:
	@docker compose exec control-node bash

.PHONY: tar1
tar1:
	@docker compose exec target-node1 bash

.PHONY: tar2
tar2:
	@docker compose exec target-node2 bash

.PHONY: clean
clean:
	@docker compose down --rmi all --volumes --remove-orphans
