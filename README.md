# Sonobuoy bulkhead plugin

This [Sonobuoy](https://github.com/heptio/sonobuoy) plugin performs automated CIS Benchmark assessments by using [kube-bench](https://github.com/aquasecurity/kube-bench) and outputs those results in the native ```kube-bench``` json format.

*NOTE*: This plugin was not officially created by either [Heptio](https://heptio.com) or [Aqua Security](https://aquasecurity.com).  It is in *very* early stages.

## Quick usage

1. Edit the ```Makefile``` to use your container registry
2. Run ```make && make push``` to build and push your image
3. Modify ```examples/benchmark.yml``` to change your image location
4. Run ```kubectl create -f examples/benchmark.yml``` to install Sonobuoy with this plugin enabled/running.
5. When the scan(s) are complete, collect the results: 
  ```kubectl cp heptio-sonobuoy/sonobuoy:/tmp/sonobuoy ./results --namespace=heptio-sonobuoy```
6. View the results: ```cd results && tar -zxvf *.tar.gz && cd plugins/bulkhead```
7. Clean up: ```kubectl delete -f examples/benchmark.yml``` (This removes all scan data, too)

# TODO
- Work on a Sonobuoy results parser
