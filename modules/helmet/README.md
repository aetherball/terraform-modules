# Helmet

This module deploys a Helm chart to a Kubernetes cluster.

It expects the chart to be located in the `charts/<name>` directory of the repository's root.

It does not run (even for _checking_ the deployment) when nothing's been changed.

## Overriding Values

You can override Helm chart values using the `set` variable:

```hcl
module "my_chart" {
  source = "./modules/helmet"

  name       = "my-chart"
  namespace  = "default"
  repo_root  = "."

  set = [
    {
      name  = "replicaCount"
      value = "3"
    },
    {
      name  = "image.tag"
      value = "v1.2.3"
    }
  ]
}
```
