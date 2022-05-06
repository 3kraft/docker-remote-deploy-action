# docker-remote-deploy-action v1.1

A simple composition github action to deploy an image to a remote docker engine using ssh.

# Usage

See [action.yml](action.yml)

## Deploy/Run an image from ghcr.io Docker registry on a remote host

```yaml
redeploy-job:
  name: Redploy
  runs-on: ubuntu-latest
  steps:
    - name: Run docker deployment
      uses: 3kraft/docker-remote-deploy-action@v1.1
      with:
        docker-host: '192.168.0.1'
        docker-host-user: root
        private-key: ${{ secrets.DOCKER_SSH_PRIVATE_KEY }}
        registry: ghcr.io
        registry-user: ${{ github.actor }}
        registry-token: ${{ secrets.GHCR_TOKEN }}
        container-name: example
        container-ports: '8080:8080'
        image-name: 'ghcr.io/${{ github.repository }}'
        tag-name: ${{ github.ref_name }}
        container-args: '-d -e SPRING_PROFILES_ACTIVE=prod --restart unless-stopped'
```

# License

This project is licensed under the terms of the [MIT license](LICENSE).

