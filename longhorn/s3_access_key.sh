kubectl -n longhorn-system create secret generic longhorn-backup-secret \
  --from-literal=AWS_ACCESS_KEY_ID=<your-access-key-id> \
  --from-literal=AWS_SECRET_ACCESS_KEY=<your-secret-access-key>

#aws s3 cp s3://vladasz-longhorn-backups/backupstore/ ./local-backup --recursive --profile longhorn-backup
