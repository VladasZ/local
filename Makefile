ping:
	ansible all -m ping

ssh:
	ssh dietpi@192.168.0.2

deploy:
	 ansible-playbook deploy-petuh.yml

up:
	vagrant up

destroy:
	vagrant destroy -f
	