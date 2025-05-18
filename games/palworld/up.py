#!/usr/bin/env python3

import subprocess

def run(cmd):
    print(f"Running: {cmd}")
    subprocess.run(cmd, shell=True, check=True)


run("kubectl apply -f ./games/palworld")
