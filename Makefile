.PHONY: deploy undeploy run

# TODO fix .env.development sym link hack (sym link doesn't work in app package)
deploy:
	rm -f ./src/.env.development.local
	azd up --no-prompt
	ln -sf ../.azure/dev/.env ./src/.env.development.local

undeploy:
	azd down --purge --force

run:
	cd src; npm run dev
