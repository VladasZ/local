ping:
	ansible all -i hosts.ini -m ping

ssh:
	ssh dietpi@192.168.0.2

deploy:
	 ansible-playbook deploy-petuh.yml