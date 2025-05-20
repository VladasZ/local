#!/usr/bin/env python3

import subprocess

def run(cmd):
    print(f"Running: {cmd}")
    subprocess.run(cmd, shell=True, check=True)


# https://setupmc.com/java-server/

run("kubectl apply -f ./games/minecraft")
