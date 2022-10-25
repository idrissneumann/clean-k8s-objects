# clean-k8s-objects

Remove finilizers and delete all the object related to a CRD in a given namespace

```shell
./clean.sh -n <NAMESPACE> -c <CRD>
```

If you want to only delete the resource that begin with a prefix filter:

```shell
./clean.sh -n <NAMESPACE> -c <CRD> -f <FILTER>
```
