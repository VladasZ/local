#kubectl edit deployment valheim-server -n valheim

kubectl patch deployment valheim-server -n valheim \
  --type='merge' \
  -p '{
    "spec": {
      "template": {
        "spec": {
          "tolerations": [
            {
              "key": "node.kubernetes.io/unreachable",
              "operator": "Exists",
              "effect": "NoExecute",
              "tolerationSeconds": 60
            },
            {
              "key": "node.kubernetes.io/not-ready",
              "operator": "Exists",
              "effect": "NoExecute",
              "tolerationSeconds": 60
            }
          ]
        }
      }
    }
  }'
