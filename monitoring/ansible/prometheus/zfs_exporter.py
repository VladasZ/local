#!/usr/bin/env python3
import subprocess
import re
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = 9900

HEALTH_MAP = {
  "ONLINE": 0,
  "DEGRADED": 1,
  "FAULTED": 2,
  "UNAVAIL": 3,
  "REMOVED": 4,
  "OFFLINE": 5
}

def get_disk_health():
  result = subprocess.run(["zpool", "status"], capture_output=True, text=True)
  lines = result.stdout.splitlines()
  device_statuses = {}

  for line in lines:
    match = re.match(r"^\s*(nvme\d+n\d+)\s+(\w+)", line)
    if match:
      device, state = match.groups()
      device_statuses[device] = HEALTH_MAP.get(state.upper(), 99)  # Unknown = 99
  return device_statuses

class MetricsHandler(BaseHTTPRequestHandler):
  def do_GET(self):
    if self.path != "/metrics":
      self.send_response(404)
      self.end_headers()
      return

    disk_statuses = get_disk_health()
    metrics = ["# HELP zfs_disk_health_status ZFS disk health (0=ONLINE, 1=DEGRADED, etc.)",
               "# TYPE zfs_disk_health_status gauge"]
    for disk, status in disk_statuses.items():
      metrics.append(f'zfs_disk_health_status{{disk="{disk}"}} {status}')

    output = "\n".join(metrics) + "\n"
    self.send_response(200)
    self.send_header("Content-Type", "text/plain; version=0.0.4")
    self.send_header("Content-Length", str(len(output)))
    self.end_headers()
    self.wfile.write(output.encode())

if __name__ == "__main__":
  server = HTTPServer(("0.0.0.0", PORT), MetricsHandler)
  print(f"Starting exporter on port {PORT}")
  server.serve_forever()
