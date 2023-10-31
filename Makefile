.PHONY: deploy undeploy run

login:
	azd auth login

deploy:
	set -o allexport;\
	. ./.env.development.local;\
	azd up --no-prompt;\
	cd src;\
	azd env get-values > .env.development.local

undeploy:
	azd down --purge --force

run:
	npm run dev
