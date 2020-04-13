### Introduction

This is an OpenShift demo showing how to do GitOps in a kubernetes way using tools like [ArgoCD](https://argoproj.github.io/argo-cd/) and [Kustomize](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/). The demo application is a product catalog using React for the front-end with Quarkus providing APIs as the back-end. The back-end was originally written in PHP and then ported to Quarkus.

![alt text](https://raw.githubusercontent.com/gnunn-gitops/product-catalog/master/docs/img/screenshot.png)

### Running demo locally

To run the demo locally on your laptop, you will need to have a MySQL or MariaDB database available. You will need to create a product database using the SQL in this repo and then update the quarkus application.properties file to reflect the location of the database.

The following repos will need to be cloned:

* [product-catalog-client](https://github.com/gnunn1/product-catalog-client)
* [product-catalog-server](https://github.com/gnunn1/product-catalog-server)


To run the quarkus application, execute ```mvn quarkus:dev``` from the root directory.

To run the client application, go into the client directory and run ```npm run start```.

### Install on OpenShift

This application makes heavy use of Kustomize and ArgoCD to deploy the application in a GitOps manner. In order to deploy this application into your own cluster,
you will need to create a new repo and setup Kustomize overlays that point to this repo. Since Kustomize supports referencing remote resources you do not need
to fork this repo, a new one will suffice.

There are two overlays you will need to create, one for argocd and one for the manifests representing the application and pipeline. Some of things that will need to be
kustomized include:

* The application URLs on your cluster so that the client and server can communicate with each other
* The argocd Application objects to reference your Kustomize overlays for the application

Examples of these can be found in the following locations in this repo:

* ArgoCD: If you look in ```/cluster/overlays/rhpds/argocd``` you can see how we patch the base items to reference the RHPDS application specific manifests
* Cluster: Have a look at ```/cluster/overlays/rhpds``` for how to create cluster specific manifests for dev, pipeline and test.

To load the projects and applications into ArgoCD, assuming it is installed in the argocd directory, use the following command:

```oc apply -k cluster/overlays/rhpds/argocd```

Once the application is installed and synchronized in ArgoCD it looks like the following:

![alt text](https://raw.githubusercontent.com/gnunn-gitops/product-catalog/master/docs/img/argocd.png)

### Test CI/CD

The demo uses OpenShift Pipelines to build the client and server images for the application. The demo does not install PipelineRun objects via ArgoCD since these objects are transitory and not meant to be managed by a GitOps tool. To load the initial PipelineRun objects, use the following command:

```oc apply -k manifests/pipelineruns/overlays/registry```

To test the CI/CD, you can add a logo to the product catalog. The code to do this is commented out and can be found in the [nav.jsx](https://github.com/gnunn1/quarkus-product-catalog/blob/master/client/src/js/components/layouts/nav.jsx#L45) file.

Once you make the code change, start the client pipeline (Jenkins or Tekton). Note that in Tekton the GUI does not support creating a new PipelineRunTask with a workspace, if you want to drive it from a GUI go into the PipelineRuns and simple rerun an existing one.

![alt text](https://raw.githubusercontent.com/gnunn-gitops/product-catalog/master/docs/img/tekton-rerun.png)

### Enterprise Registry

The demo is used and tested primarily with an enterprise Registry. In my case I'm leveraging quay.io though you can use anything. In order to support GitOps with the enterprise registry secret, Bitnami Sealed Secrets are used. When creating your cluster overlay you will need to either provide the secret directly (strongly not recommended), or encrypt your own secret using kubeseal.

An example of creating a standard secret is included in the kustomization file ```cluster/overlays/default/pipeline/kustomization.yaml```. To use it, uncomment the secret generator in the file, you will also need to provide a dockerconfigjson file for the secret similar to below:

```
{
	"auths": {
		"<registry>": {
		  "auth": "<base64(Username:Password)>"
		}
	},
	"HttpHeaders": {
		"User-Agent": "Docker-Client/18.09.7 (linux)"
	}
}
```

Replace the ```<base64(Username:Password)>``` with a base64 string of your username and password. Replace ```<registry>``` with your registry name, i.e. ```quay.io``` if using Quay.