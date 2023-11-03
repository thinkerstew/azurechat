.PHONY: deploy undeploy run

login:
	azd auth login

deploy:
	set -o allexport;\
	. ./.env.development.local;\
	azd up --no-prompt;\
	cd src;\
	echo "# This file is automatically generated by 'make deploy' command. Do not edit it manually." > .env.development.local;\
	azd env get-values >> .env.development.local

deploy-ts:
	set -o allexport;\
	. ./.env.dev-ts.local;\
	azd up --no-prompt;\
	cd src;\
	echo "# This file is automatically generated by 'make deploy' command. Do not edit it manually." > .env.development.local;\
	azd env get-values >> .env.development.local

undeploy:
	azd down --purge --force

install:
	cd src; npm install

run:
	cd src; npm run dev
