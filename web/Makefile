all: help

db_setup_mysql:
	mysql -uroot -p < db/schema-mysql.sql

help:
	@echo "    help            - command reference"
	@echo "    db_setup_mysql  - setup MySQL database"
	@echo "    run_development - run Mojo web server in development mode"
	@echo "    run_production  - run Mojo web server in production mode"

run_development:
	MOJO_LOG_LEVEL=debug MOJO_MODE=development morbo public/index.pl

run_production:
	MOJO_LOG_LEVEL=error MOJO_MODE=production morbo public/index.pl

.PHONY: db_setup_mysql run_development run_production
