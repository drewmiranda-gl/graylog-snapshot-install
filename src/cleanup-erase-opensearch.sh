#!/bin/bash

echo "Stopping OpenSearch..."
systemctl stop opensearch
rm -rf /var/lib/opensearch/nodes/0
echo "Starting OpenSearch..."
systemctl start opensearch