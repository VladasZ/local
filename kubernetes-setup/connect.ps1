# CONFIGURATION - edit these values
$ControlPlaneHost = "tc1"
$ControlPlaneIP = "192.168.0.201"
$RemoteKubeConfigPath = "/etc/rancher/k3s/k3s.yaml"
$LocalKubeConfigPath = "$HOME\.kube\config"
$TempPath = "$env:TEMP\k3s_patched.yaml"
$RemoteUser = "vladas"

# 1. Create .kube directory if it doesn't exist
$kubeDir = "$HOME\.kube"
if (-not (Test-Path -Path $kubeDir)) {
  New-Item -ItemType Directory -Path $kubeDir
}

# 2. Read and patch kubeconfig remotely
$sshCommand = @"
cat $RemoteKubeConfigPath | sed 's/127.0.0.1/$ControlPlaneHost/' > /tmp/k3s_patched.yaml
"@
ssh "$RemoteUser@$ControlPlaneHost" $sshCommand

# 3. Copy the patched kubeconfig to local machine
scp "$RemoteUser@${ControlPlaneHost}:/tmp/k3s_patched.yaml" $TempPath

# 4. Move it to ~/.kube/config
Copy-Item -Path $TempPath -Destination $LocalKubeConfigPath -Force

# 5. Add host entry if missing
$hostsPath = "$env:SystemRoot\System32\drivers\etc\hosts"
$entry = "$ControlPlaneIP`t$ControlPlaneHost"
if (-not (Select-String -Path $hostsPath -Pattern "$ControlPlaneIP\s+$ControlPlaneHost")) {
  Add-Content -Path $hostsPath -Value $entry
  Write-Host "Added '$entry' to hosts file."
} else {
  Write-Host "Host entry already exists."
}
