# clean-k8s-objects

Remove finilizers and delete all the object related to a CRD in a given namespace

## Git repositories

* Main repo: https://gitlab.comwork.io/oss/clean-k8s-objects
* Github mirror: https://github.com/idrissneumann/clean-k8s-objects.git
* Gitlab mirror: https://gitlab.com/ineumann/clean-k8s-objects.git
* Froggit mirror: https://lab.frogg.it/ineumann/clean-k8s-objects.git

## Usages

```shell
./clean.sh -n <NAMESPACE> -c <CRD>
```

If you want to only delete the resource that begin with a prefix filter:

```shell
./clean.sh -n <NAMESPACE> -c <CRD> -f <FILTER>
```
