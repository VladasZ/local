ping:
	ansible all -i hosts.ini -m ping

ssh:
	ssh vladas@192.168.0.6

deploy:
	 ansible-playbook deploy-app.yml