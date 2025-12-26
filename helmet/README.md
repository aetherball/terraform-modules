# Helmet

This module deploys a Helm chart to a Kubernetes cluster.

It expects the chart to be located in the `charts/<name>` directory of the repository's root.

It does not run (even for _checking_ the deployment) when nothing's been changed.
