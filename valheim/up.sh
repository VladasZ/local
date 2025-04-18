
kubectl create namespace valheim

helm repo add valheim-k8s https://addyvan.github.io/valheim-k8s/
helm repo update

helm install valheim-server valheim-k8s/valheim-k8s \
  --namespace valheim \
  --set worldName=EmotionalSupport \
  --set serverName=Kurjatnik \
  --set password=password \
  --set storage.kind=persistentVolumeClaim \
  --set storage.pvc.storageClassName=longhorn \
  --set storage.pvc.size=10Gi \
  --set networking.serviceType=LoadBalancer \
  --set networking.loadBalancerIP=192.168.0.2 \
  --set networking.gamePort=24560 \
  --set networking.publishQueryPort=true

#kubectl logs -n valheim deploy/valheim-server -f
#kubectl scale deployment valheim-server --replicas=0 -n valheim
#kubectl get svc -n valheim