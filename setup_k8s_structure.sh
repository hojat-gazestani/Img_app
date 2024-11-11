#!/bin/bash

# Define environment directories and basic Kubernetes structure
ENVIRONMENTS=("staging" "production")
DIRS=("deployments" "services" "configmaps" "secrets" "ingress")
HELM_CHART_NAME="img-app-chart"

# Create directories for each environment
for env in "${ENVIRONMENTS[@]}"; do
  echo "Creating directory structure for $env environment..."
  mkdir -p "k8s-manifests/$env"
  for dir in "${DIRS[@]}"; do
    mkdir -p "k8s-manifests/$env/$dir"
    # Create a placeholder YAML file for guidance
    touch "k8s-manifests/$env/$dir/README.md"
    echo "# Add your $dir resources for $env environment here." > "k8s-manifests/$env/$dir/README.md"
  done
done

# Helm chart directory structure
echo "Setting up Helm chart structure..."
mkdir -p "helm/$HELM_CHART_NAME/templates"
mkdir -p "helm/$HELM_CHART_NAME/charts"

# Basic Helm chart files
touch "helm/$HELM_CHART_NAME/Chart.yaml"
touch "helm/$HELM_CHART_NAME/values.yaml"
touch "helm/$HELM_CHART_NAME/templates/deployment.yaml"
touch "helm/$HELM_CHART_NAME/templates/service.yaml"

# Populate the basic Helm chart files
cat <<EOF > "helm/$HELM_CHART_NAME/Chart.yaml"
apiVersion: v2
name: $HELM_CHART_NAME
description: A Helm chart for Kubernetes
version: 0.1.0
appVersion: "1.0"
EOF

cat <<EOF > "helm/$HELM_CHART_NAME/values.yaml"
# Default values for $HELM_CHART_NAME.
# Override these values in environment-specific files.
replicaCount: 1
image:
  repository: nginx
  tag: latest
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80
EOF

cat <<EOF > "helm/$HELM_CHART_NAME/templates/deployment.yaml"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "\$HELM_CHART_NAME.fullname" . }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ include "\$HELM_CHART_NAME.name" . }}
  template:
    metadata:
      labels:
        app: {{ include "\$HELM_CHART_NAME.name" . }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          ports:
            - containerPort: {{ .Values.service.port }}
EOF

cat <<EOF > "helm/$HELM_CHART_NAME/templates/service.yaml"
apiVersion: v1
kind: Service
metadata:
  name: {{ include "\$HELM_CHART_NAME.fullname" . }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.port }}
  selector:
    app: {{ include "\$HELM_CHART_NAME.name" . }}
EOF

echo "Directory structure and Helm chart setup complete."

