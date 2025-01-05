# Biblioteca Helm Charts

[Helm](https://helm.sh) repo for different charts related to Biblioteca which can be installed on [Kubernetes](https://kubernetes.io)

### Add Helm repository

To install the repo just run:

```bash
helm repo add biblioteca https://biblioteca.github.io/helm/
helm repo update
```

### Helm Charts

* [biblioverse](https://biblioverse.github.io/helm/)

  ```bash
  helm install my-release biblioverse/biblioteca
  ```

For more information, please checkout the chart level [README.md](./charts/biblioteca/README.md).

#### Questions and Discussions
[GitHub Discussion](https://github.com/biblioverse/helm/discussions)

#### Bugs and other Issues
If you have a bug to report or a feature to request, you can first search the [GitHub Issues](https://github.com/biblioverse/helm/issues), and  if you can't find what you're looking for, feel free to open an issue.
