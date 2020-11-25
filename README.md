### Introduction

This is an OpenShift demo showing how to do GitOps in a kubernetes way using tools like [ArgoCD](https://argoproj.github.io/argo-cd/) and [Kustomize](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/). The demo application is a three tier application using React for the front-end with Quarkus providing APIs as the back-end. The back-end was originally written in PHP and then ported to Quarkus. The application itself is a simple product catalog:

![alt text](https://raw.githubusercontent.com/gnunn-gitops/product-catalog/master/docs/img/screenshot.png)

The topology view in OpenShift shows the three tiers of the application:

![alt text](https://raw.githubusercontent.com/gnunn-gitops/product-catalog/master/docs/img/topology.png)

### Running demo locally

To run the demo locally on your laptop, you will need to have a MySQL or MariaDB database available. You will need to create a product database using the SQL in this repo and then update the quarkus application.properties file to reflect the location of the database.

The following repos will need to be cloned:

* [product-catalog-client](https://github.com/gnunn-gitops/product-catalog-client)
* [product-catalog-server](https://github.com/gnunn-gitops/product-catalog-server)


To run the quarkus application, execute ```mvn quarkus:dev``` from the root directory.

To run the client application, go into the client directory and run ```npm run start```.

### Install on OpenShift

This application makes heavy use of Kustomize and ArgoCD to deploy the application in a GitOps manner. In order to deploy this application into your own cluster,
you will need to create a new repo and setup Kustomize overlays that point to this repo. Since Kustomize supports referencing remote resources you do not need
to fork this repo, a new one will suffice.

In order to make this easier, a [product-catalog-template](https://github.com/gnunn-gitops/product-catalog-template) repo is available that you can fork. It includes detailed instructions with regards to pre-requisities and what needs to be modified to deploy the demo in your own cluster.

Once deployed in your cluster under ArgoCD it should appear as follows:

![alt text](https://raw.githubusercontent.com/gnunn-gitops/product-catalog/master/docs/img/argocd.png)

### Test CI/CD Pipelines

The demo uses OpenShift Pipelines to build the client and server images for the application. The demo does not install PipelineRun objects via ArgoCD since these objects are transitory and not meant to be managed by a GitOps tool. To load the initial PipelineRun objects, use the following command:

```
oc apply -k manifests/tekton/pipelineruns/client/base
oc apply -k manifests/tekton/pipelineruns/server/base
```

To test the pipelines are actually taking changes, you can add a logo to the product catalog. The code to do this is commented out and can be found in the [nav.jsx](https://github.com/gnunn1/quarkus-product-catalog/blob/master/client/src/js/components/layouts/nav.jsx#L45) file.

Once you make the code change, start the client pipeline. Note that in OpenShift Pipelines the GUI does not support creating a new PipelineRunTask with a workspace, if you want to drive it from a GUI go into the PipelineRuns and simple rerun an existing one.

![alt text](https://raw.githubusercontent.com/gnunn-gitops/product-catalog/master/docs/img/tekton-rerun.png)

### Test Prod Pipeline

The demo uses a pipeline called ```push-prod-pr``` that creates a pull request in github. When the pull request is merged ArgoCD will see the change in git and automatically deploy the updated image for you. The client and server pipelines can run the push-prod-pr automatically if you set the ```push-to-prod``` parameter to true to have it trigger the pipeline automatically. The default for this parameter is false.

Note that OpenShift Pipelines currently shows conditions which are not met as failed steps in the pipeline so don't be alarmed that client and server pipelines appear to be failing when ```push-to-prod``` is set to false.

To execute the pipelines you will need to create pipelinerun objects, base versions are available in ```manifests/tekton/pipelineruns```. A script is also available at ```scripts/apply-pipelineruns.sh``` to load the client and server pipelineruns however you will need to modify the pipelineruns to reflect your cluster and enterprise registry.

### Enterprise Registry

The demo is used and tested primarily with an enterprise registry, in my case I use quay.io. See the [product-catalog-template](https://github.com/gnunn-gitops/product-catalog-template) for more information on this.

The demo uses the git commit hash to tag the client and server images in the registry, when using quay.io it is highly recommended to deploy the Container Security Operator so that quay vulnerability scans are shown. From a demo perspective, I find showing how older images have more vulnerabilities highlights the benefits of using Red Hat base images.

### Monitoring

A basic monitoring system is installed as part of the demo, as a pre-requisite it requires [monitoring for user-defined projects](https://docs.openshift.com/container-platform/4.6/monitoring/enabling-monitoring-for-user-defined-projects.html) to be enabled in OpenShift.

This demo deploys grafana into the ```product-catalog-monitor``` namespace along with a simple dashboard for the server application. The dashboard tracks JVM metrics as well as API calls to the server, with no load the API call metrics will be flat and that is normal:

![alt text](https://raw.githubusercontent.com/gnunn-gitops/product-catalog/master/docs/img/monitoring.png)

There's a sample siege script that can be used to drive some load if desired under scripts, you will need to update the script to reflect the endpoints in your cluster.