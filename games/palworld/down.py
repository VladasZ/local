#!/usr/bin/env python3

import subprocess

NAMESPACE = "palworld"
DELETE_NAMESPACE = True

resources_to_delete = [
    "all",
    "configmap",
    "secret",
    "pvc",
    "ingress",
    "job",
    "cronjob",
    "serviceaccount",
]

def run(cmd):
    print(f"Running: {cmd}")
    subprocess.run(cmd, shell=True, check=True)

def delete_all_resources(namespace):
    resources = ",".join(resources_to_delete)
    run(f"kubectl delete {resources} --all -n {namespace}")

def delete_and_recreate_namespace(namespace):
    run(f"kubectl delete namespace {namespace}")
    run(f"kubectl create namespace {namespace}")

if __name__ == "__main__":
    try:
        delete_all_resources(NAMESPACE)
        if DELETE_NAMESPACE:
            delete_and_recreate_namespace(NAMESPACE)
        print(f"✅ Namespace '{NAMESPACE}' cleaned successfully.")
    except subprocess.CalledProcessError as e:
        print(f"❌ Command failed: {e}")
