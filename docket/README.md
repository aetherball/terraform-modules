# Docket

This module builds and pushes a Docker image to a container registry, and _caches_ the build process (even for a stateless runner!), by pulling the layers off of the registry at build time.

It expects the images to be 1. fully self-contained (currently we only look at the `Dockerfile` to detect change, so no copying over files into the Dockerfile), and 2. located in the `docker/<name>` directory of the repository's root.

It does not run (even for _checking_ the build) when nothing's been changed.

## Requirements

Beyond the input variables, this module _expects_ the following environment variables to be set in the execution environment, so that we can actually see the Terraform build outputs:

- `CR_USERNAME`
- `CR_PASSWORD`
