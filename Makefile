ping:
	ansible all -m ping

ssh:
	ssh dietpi@192.168.0.2

deploy:
	 ansible-playbook playbooks/deploy_petuh.yml

up:
	vagrant up

destroy:
	vagrant destroy -f

lint:
	ansible-lint

prepare:
	ansible-playbook playbooks/prepare.yml -l linux

bench:
	ansible-playbook playbooks/bench.yml -l linux

prom:
	ansible-playbook playbooks/prometheus/install_prometheus.yml

kubeup:
	ansible-playbook kubernetes-setup/up.yml -K

kubedown:
	ansible-playbook kubernetes-setup/down.yml

apply:
	kubectl apply --recursive --filename=kubernetes

routes:
	kubectl apply -f kubernetes-setup/routing
