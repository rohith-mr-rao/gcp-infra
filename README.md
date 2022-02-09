
## Google Kubernetes Engine (GKE) Module

This repo contains a [Terraform](https://www.terraform.io) module for running a Kubernetes cluster on [Google Cloud Platform (GCP)](https://cloud.google.com/)
using [Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine/).

## Quickstart

If you want to quickly spin up a GKE Private Cluster, you can run the tf scripts that is in the gcp-modules directory of this
repo.

## What's in this repo

This repo has the following folder structure:

- [gcp-modules](https://github.com/Deloitte/GardeniaBP1-PA-Infra/tree/dev/gcp-modules): The folder contains the tf files to deploy a VPC, two subnets Cloud NAT, Cloud Router and a Private GKE Cluster

- [shared-modules](https://github.com/Deloitte/GardeniaBP1-PA-Infra/tree/dev/shared-modules): This folder contains the
  main implementation code for this Module, broken down into multiple standalone submodules.

## Usage

Open gcp-modules folder and perform the following commands:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

## What is Kubernetes?

[Kubernetes](https://kubernetes.io) is an open source container management system for deploying, scaling, and managing
containerized applications. Kubernetes is built by Google based on their internal proprietary container management
systems (Borg and Omega). Kubernetes provides a cloud agnostic platform to deploy your containerized applications with
built in support for common operational tasks such as replication, autoscaling, self-healing, and rolling deployments.

You can learn more about Kubernetes from [the official documentation](https://kubernetes.io/docs/tutorials/kubernetes-basics/).

## What is GKE?

Google Kubernetes Engine or "GKE" is a Google-managed Kubernetes environment. GKE is a fully managed experience; it
handles the management/upgrading of the Kubernetes cluster master as well as autoscaling of "nodes" through "node pool"
templates.

Through GKE, your Kubernetes deployments will have first-class support for GCP IAM identities, built-in configuration of
high-availability and secured clusters, as well as native access to GCP's networking features such as load balancers.

## <a name="how-to-run-applications"></a>How do you run applications on Kubernetes?

There are three different ways you can schedule your application on a Kubernetes cluster. In all three, your application
Docker containers are packaged as a [Pod](https://kubernetes.io/docs/concepts/workloads/pods/pod/), which are the
smallest deployable unit in Kubernetes, and represent one or more Docker containers that are tightly coupled. Containers
in a Pod share certain elements of the kernel space that are traditionally isolated between containers, such as the
network space (the containers both share an IP and thus the available ports are shared), IPC namespace, and PIDs in some
cases.

Pods are considered to be relatively ephemeral disposable entities in the Kubernetes ecosystem. This is because Pods are
designed to be mobile across the cluster so that you can design a scalable fault tolerant system. As such, Pods are
generally scheduled with
[Controllers](https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/#pods-and-controllers) that manage the
lifecycle of a Pod. Using Controllers, you can schedule your Pods as:

- Jobs, which are Pods with a controller that will guarantee the Pods run to completion.
- Deployments behind a Service, which are Pods with a controller that implement lifecycle rules to provide replication
  and self-healing capabilities. Deployments will automatically reprovision failed Pods, or migrate Pods to healthy
  nodes off of failed nodes. A Service constructs a consistent endpoint that can be used to access the Deployment.
- Daemon Sets, which are Pods that are scheduled on all worker nodes. Daemon Sets schedule exactly one instance of a Pod
  on each node. Like Deployments, Daemon Sets will reprovision failed Pods and schedule new ones automatically on
  new nodes that join the cluster.

<!-- TODO: ## What parts of the Production Grade Infrastructure Checklist are covered by this Module? -->

## What's a Module?

A Module is a canonical, reusable, best-practices definition for how to run a single piece of infrastructure, such
as a database or server cluster. Each Module is written using a combination of [Terraform](https://www.terraform.io/)
and scripts (mostly bash) and include automated tests, documentation, and examples. It is maintained both by the open
source community and companies that provide commercial support.

Instead of figuring out the details of how to run a piece of infrastructure from scratch, you can reuse
existing code that has been proven in production. And instead of maintaining all that infrastructure code yourself,
you can leverage the work of the Module community to pick up infrastructure improvements through
a version number bump.

## Inputs


## GKE
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| add\_cluster\_firewall\_rules | Create additional firewall rules | `bool` | `false` | no |
| add\_master\_webhook\_firewall\_rules | Create master\_webhook firewall rules for ports defined in `firewall_inbound_ports` | `bool` | `false` | no |
| add\_shadow\_firewall\_rules | Create GKE shadow firewall (the same as default firewall rules with firewall logs enabled). | `bool` | `false` | no |
| authenticator\_security\_group | The name of the RBAC security group for use with Google security groups in Kubernetes RBAC. Group name must be in format gke-security-groups@yourdomain.com | `string` | `null` | no |
| basic\_auth\_password | The password to be used with Basic Authentication. | `string` | `""` | no |
| basic\_auth\_username | The username to be used with Basic Authentication. An empty value will disable Basic Authentication, which is the recommended configuration. | `string` | `""` | no |
| cloudrun | (Beta) Enable CloudRun addon | `bool` | `false` | no |
| cloudrun\_load\_balancer\_type | (Beta) Configure the Cloud Run load balancer type. External by default. Set to `LOAD_BALANCER_TYPE_INTERNAL` to configure as an internal load balancer. | `string` | `""` | no |
| cluster\_autoscaling | Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling) | <pre>object({<br>    enabled             = bool<br>    autoscaling_profile = string<br>    min_cpu_cores       = number<br>    max_cpu_cores       = number<br>    min_memory_gb       = number<br>    max_memory_gb       = number<br>  })</pre> | <pre>{<br>  "autoscaling_profile": "BALANCED",<br>  "enabled": false,<br>  "max_cpu_cores": 0,<br>  "max_memory_gb": 0,<br>  "min_cpu_cores": 0,<br>  "min_memory_gb": 0<br>}</pre> | no |
| cluster\_ipv4\_cidr | The IP address range of the kubernetes pods in this cluster. Default is an automatically assigned CIDR. | `any` | `null` | no |
| cluster\_resource\_labels | The GCE resource labels (a map of key/value pairs) to be applied to the cluster | `map(string)` | `{}` | no |
| cluster\_telemetry\_type | Available options include ENABLED, DISABLED, and SYSTEM\_ONLY | `string` | `null` | no |
| config\_connector | (Beta) Whether ConfigConnector is enabled for this cluster. | `bool` | `false` | no |
| configure\_ip\_masq | Enables the installation of ip masquerading, which is usually no longer required when using aliasied IP addresses. IP masquerading uses a kubectl call, so when you have a private cluster, you will need access to the API server. | `bool` | `false` | no |
| create\_service\_account | Defines if service account specified to run nodes should be created. | `bool` | `true` | no |
| database\_encryption | Application-layer Secrets Encryption settings. The object format is {state = string, key\_name = string}. Valid values of state are: "ENCRYPTED"; "DECRYPTED". key\_name is the name of a CloudKMS key. | `list(object({ state = string, key_name = string }))` | <pre>[<br>  {<br>    "key_name": "",<br>    "state": "DECRYPTED"<br>  }<br>]</pre> | no |
| datapath\_provider | The desired datapath provider for this cluster. By default, uses the IPTables-based kube-proxy implementation. | `string` | `"DATAPATH_PROVIDER_UNSPECIFIED"` | no |
| default\_max\_pods\_per\_node | The maximum number of pods to schedule per node | `number` | `110` | no |
| deploy\_using\_private\_endpoint | (Beta) A toggle for Terraform and kubectl to connect to the master's internal IP address during deployment. | `bool` | `false` | no |
| description | The description of the cluster | `string` | `""` | no |
| disable\_default\_snat | Whether to disable the default SNAT to support the private use of public IP addresses | `bool` | `false` | no |
| disable\_legacy\_metadata\_endpoints | Disable the /0.1/ and /v1beta1/ metadata server endpoints on the node. Changing this value will cause all node pools to be recreated. | `bool` | `true` | no |
| dns\_cache | (Beta) The status of the NodeLocal DNSCache addon. | `bool` | `false` | no |
| enable\_binary\_authorization | Enable BinAuthZ Admission controller | `bool` | `false` | no |
| enable\_intranode\_visibility | Whether Intra-node visibility is enabled for this cluster. This makes same node pod to pod traffic visible for VPC network | `bool` | `false` | no |
| enable\_kubernetes\_alpha | Whether to enable Kubernetes Alpha features for this cluster. Note that when this option is enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days. | `bool` | `false` | no |
| enable\_l4\_ilb\_subsetting | Enable L4 ILB Subsetting on the cluster | `bool` | `false` | no |
| enable\_network\_egress\_export | Whether to enable network egress metering for this cluster. If enabled, a daemonset will be created in the cluster to meter network egress traffic. | `bool` | `false` | no |
| enable\_pod\_security\_policy | enabled - Enable the PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created. | `bool` | `false` | no |
| enable\_private\_endpoint | (Beta) Whether the master's internal IP address is used as the cluster endpoint | `bool` | `false` | no |
| enable\_private\_nodes | (Beta) Whether nodes have internal IP addresses only | `bool` | `false` | no |
| enable\_resource\_consumption\_export | Whether to enable resource consumption metering on this cluster. When enabled, a table will be created in the resource export BigQuery dataset to store resource consumption data. The resulting table can be joined with the resource usage table or with BigQuery billing export. | `bool` | `true` | no |
| enable\_shielded\_nodes | Enable Shielded Nodes features on all nodes in this cluster | `bool` | `true` | no |
| enable\_tpu | Enable Cloud TPU resources in the cluster. WARNING: changing this after cluster creation is destructive! | `bool` | `false` | no |
| enable\_vertical\_pod\_autoscaling | Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it | `bool` | `false` | no |
| firewall\_inbound\_ports | List of TCP ports for admission/webhook controllers. Either flag `add_master_webhook_firewall_rules` or `add_cluster_firewall_rules` (also adds egress rules) must be set to `true` for inbound-ports firewall rules to be applied. | `list(string)` | <pre>[<br>  "8443",<br>  "9443",<br>  "15017"<br>]</pre> | no |
| firewall\_priority | Priority rule for firewall rules | `number` | `1000` | no |
| gce\_pd\_csi\_driver | (Beta) Whether this cluster should enable the Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver. | `bool` | `false` | no |
| gcloud\_upgrade | Whether to upgrade gcloud at runtime | `bool` | `false` | no |
| grant\_registry\_access | Grants created cluster-specific service account storage.objectViewer role. | `bool` | `false` | no |
| horizontal\_pod\_autoscaling | Enable horizontal pod autoscaling addon | `bool` | `true` | no |
| http\_load\_balancing | Enable httpload balancer addon | `bool` | `true` | no |
| identity\_namespace | Workload Identity namespace. (Default value of `enabled` automatically sets project based namespace `[project_id].svc.id.goog`) | `string` | `"enabled"` | no |
| impersonate\_service\_account | An optional service account to impersonate for gcloud commands. If this service account is not specified, the module will use Application Default Credentials. | `string` | `""` | no |
| initial\_node\_count | The number of nodes to create in this cluster's default node pool. | `number` | `0` | no |
| ip\_masq\_link\_local | Whether to masquerade traffic to the link-local prefix (169.254.0.0/16). | `bool` | `false` | no |
| ip\_masq\_resync\_interval | The interval at which the agent attempts to sync its ConfigMap file from the disk. | `string` | `"60s"` | no |
| ip\_range\_pods | The _name_ of the secondary subnet ip range to use for pods | `string` | n/a | yes |
| ip\_range\_services | The _name_ of the secondary subnet range to use for services | `string` | n/a | yes |
| issue\_client\_certificate | Issues a client certificate to authenticate to the cluster endpoint. To maximize the security of your cluster, leave this option disabled. Client certificates don't automatically rotate and aren't easily revocable. WARNING: changing this after cluster creation is destructive! | `bool` | `false` | no |
| istio | (Beta) Enable Istio addon | `bool` | `false` | no |
| istio\_auth | (Beta) The authentication type between services in Istio. | `string` | `"AUTH_MUTUAL_TLS"` | no |
| kalm\_config | (Beta) Whether KALM is enabled for this cluster. | `bool` | `false` | no |
| kubernetes\_version | The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region. | `string` | `"latest"` | no |
| logging\_service | The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none | `string` | `"logging.googleapis.com/kubernetes"` | no |
| maintenance\_end\_time | Time window specified for recurring maintenance operations in RFC3339 format | `string` | `""` | no |
| maintenance\_exclusions | List of maintenance exclusions. A cluster can have up to three | `list(object({ name = string, start_time = string, end_time = string }))` | `[]` | no |
| maintenance\_recurrence | Frequency of the recurring maintenance window in RFC5545 format. | `string` | `""` | no |
| maintenance\_start\_time | Time window specified for daily or recurring maintenance operations in RFC3339 format | `string` | `"05:00"` | no |
| master\_authorized\_networks | List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists). | `list(object({ cidr_block = string, display_name = string }))` | `[]` | no |
| master\_global\_access\_enabled | (Beta) Whether the cluster master is accessible globally (from any region) or only within the same region as the private endpoint. | `bool` | `true` | no |
| master\_ipv4\_cidr\_block | (Beta) The IP range in CIDR notation to use for the hosted master network | `string` | `"10.0.0.0/28"` | no |
| monitoring\_service | The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none | `string` | `"monitoring.googleapis.com/kubernetes"` | no |
| name | The name of the cluster (required) | `string` | n/a | yes |
| network | The VPC network to host the cluster in (required) | `string` | n/a | yes |
| network\_policy | Enable network policy addon | `bool` | `false` | no |
| network\_policy\_provider | The network policy provider. | `string` | `"CALICO"` | no |
| network\_project\_id | The project ID of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| node\_metadata | Specifies how node metadata is exposed to the workload running on the node | `string` | `"GKE_METADATA_SERVER"` | no |
| node\_pools | List of maps containing node pools | `list(map(string))` | <pre>[<br>  {<br>    "name": "default-node-pool"<br>  }<br>]</pre> | no |
| node\_pools\_labels | Map of maps containing node labels by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| node\_pools\_linux\_node\_configs\_sysctls | Map of maps containing linux node config sysctls by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| node\_pools\_metadata | Map of maps containing node metadata by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| node\_pools\_oauth\_scopes | Map of lists containing node oauth scopes by node-pool name | `map(list(string))` | <pre>{<br>  "all": [<br>    "https://www.googleapis.com/auth/cloud-platform"<br>  ],<br>  "default-node-pool": []<br>}</pre> | no |
| node\_pools\_tags | Map of lists containing node network tags by node-pool name | `map(list(string))` | <pre>{<br>  "all": [],<br>  "default-node-pool": []<br>}</pre> | no |
| node\_pools\_taints | Map of lists containing node taints by node-pool name | `map(list(object({ key = string, value = string, effect = string })))` | <pre>{<br>  "all": [],<br>  "default-node-pool": []<br>}</pre> | no |
| non\_masquerade\_cidrs | List of strings in CIDR notation that specify the IP address ranges that do not use IP masquerading. | `list(string)` | <pre>[<br>  "10.0.0.0/8",<br>  "172.16.0.0/12",<br>  "192.168.0.0/16"<br>]</pre> | no |
| notification\_config\_topic | The desired Pub/Sub topic to which notifications will be sent by GKE. Format is projects/{project}/topics/{topic}. | `string` | `""` | no |
| project\_id | The project ID to host the cluster in (required) | `string` | n/a | yes |
| region | The region to host the cluster in (optional if zonal cluster / required if regional) | `string` | `null` | no |
| regional | Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!) | `bool` | `true` | no |
| registry\_project\_ids | Projects holding Google Container Registries. If empty, we use the cluster project. If a service account is created and the `grant_registry_access` variable is set to `true`, the `storage.objectViewer` role is assigned on these projects. | `list(string)` | `[]` | no |
| release\_channel | The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `UNSPECIFIED`. | `string` | `null` | no |
| remove\_default\_node\_pool | Remove default node pool while setting up the cluster | `bool` | `false` | no |
| resource\_usage\_export\_dataset\_id | The ID of a BigQuery Dataset for using BigQuery as the destination of resource usage export. | `string` | `""` | no |
| sandbox\_enabled | (Beta) Enable GKE Sandbox (Do not forget to set `image_type` = `COS_CONTAINERD` to use it). | `bool` | `false` | no |
| service\_account | The service account to run nodes as if not overridden in `node_pools`. The create\_service\_account variable default value (true) will cause a cluster-specific service account to be created. | `string` | `""` | no |
| shadow\_firewall\_rules\_priority | The firewall priority of GKE shadow firewall rules. The priority should be less than default firewall, which is 1000. | `number` | `999` | no |
| skip\_provisioners | Flag to skip all local-exec provisioners. It breaks `stub_domains` and `upstream_nameservers` variables functionality. | `bool` | `false` | no |
| stub\_domains | Map of stub domains and their resolvers to forward DNS queries for a certain domain to an external DNS server | `map(list(string))` | `{}` | no |
| subnetwork | The subnetwork to host the cluster in (required) | `string` | n/a | yes |
| upstream\_nameservers | If specified, the values replace the nameservers taken by default from the node’s /etc/resolv.conf | `list(string)` | `[]` | no |
| zones | The zones to host the cluster in (optional if regional cluster / required if zonal) | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| ca\_certificate | Cluster ca certificate (base64 encoded) |
| cloudrun\_enabled | Whether CloudRun enabled |
| cluster\_id | Cluster ID |
| dns\_cache\_enabled | Whether DNS Cache enabled |
| endpoint | Cluster endpoint |
| horizontal\_pod\_autoscaling\_enabled | Whether horizontal pod autoscaling enabled |
| http\_load\_balancing\_enabled | Whether http load balancing enabled |
| identity\_namespace | Workload Identity namespace |
| instance\_group\_urls | List of GKE generated instance groups |
| intranode\_visibility\_enabled | Whether intra-node visibility is enabled |
| istio\_enabled | Whether Istio is enabled |
| location | Cluster location (region if regional cluster, zone if zonal cluster) |
| logging\_service | Logging service used |
| master\_authorized\_networks\_config | Networks from which access to master is permitted |
| master\_ipv4\_cidr\_block | The IP range in CIDR notation used for the hosted master network |
| master\_version | Current master kubernetes version |
| min\_master\_version | Minimum master kubernetes version |
| monitoring\_service | Monitoring service used |
| name | Cluster name |
| network\_policy\_enabled | Whether network policy enabled |
| node\_pools\_names | List of node pools names |
| node\_pools\_versions | List of node pools versions |
| peering\_name | The name of the peering between this cluster and the Google owned VPC. |
| pod\_security\_policy\_enabled | Whether pod security policy is enabled |
| region | Cluster region |
| release\_channel | The release channel of this cluster |
| service\_account | The service account to default running nodes as if not overridden in `node_pools`. |
| tpu\_ipv4\_cidr\_block | The IP range in CIDR notation used for the TPUs |
| type | Cluster type (regional / zonal) |
| vertical\_pod\_autoscaling\_enabled | Whether veritical pod autoscaling is enabled |
| zones | List of zones in which the cluster resides |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## node_pools variable
The node_pools variable takes the following parameters:

| Name | Description | Default | Requirement |
| --- | --- | --- | --- |
| accelerator_count | The number of the guest accelerator cards exposed to this instance | 0 | Optional |
| accelerator_type | The accelerator type resource to expose to the instance | " " | Optional |
| auto_repair | Whether the nodes will be automatically repaired | true | Optional |
| autoscaling | Configuration required by cluster autoscaler to adjust the size of the node pool to the current cluster usage | true | Optional |
| auto_upgrade | Whether the nodes will be automatically upgraded | true (if cluster is regional) | Optional |
| cpu_manager_policy | The CPU manager policy on the node. One of "none" or "static". | "none" | Optional |
| disk_size_gb | Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB | 100 | Optional |
| disk_type | Type of the disk attached to each node (e.g. 'pd-standard' or 'pd-ssd') | pd-standard | Optional |
| effect | Effect for the taint | | Required |
| enable_integrity_monitoring | Enables monitoring and attestation of the boot integrity of the instance. The attestation is performed against the integrity policy baseline. This baseline is initially derived from the implicitly trusted boot image when the instance is created. | true | Optional |
| enable_secure_boot | Secure Boot helps ensure that the system only runs authentic software by verifying the digital signature of all boot components, and halting the boot process if signature verification fails. | false | Optional |
| image_type | The image type to use for this node. Note that changing the image type will delete and recreate all nodes in the node pool | COS | Optional |
| initial_node_count | The initial number of nodes for the pool. In regional or multi-zonal clusters, this is the number of nodes per zone. Changing this will force recreation of the resource. Defaults to the value of min_count | " " | Optional |
| key | The key required for the taint | | Required |
| local_ssd_count | The amount of local SSD disks that will be attached to each cluster node and may be used as a `hostpath` volume or a `local` PersistentVolume.  | 0 | Optional |
| local_ssd_ephemeral_count | The amount of local SSD disks that will be attached to each cluster node and assigned as scratch space as an `emptyDir` volume. If unspecified, ephemeral storage is backed by the cluster node boot disk. | 0 | Optional |
| machine_type | The name of a Google Compute Engine machine type | e2-medium | Optional |
| max_count | Maximum number of nodes in the NodePool. Must be >= min_count | 100 | Optional |
| max_pods_per_node | The maximum number of pods per node in this cluster | null | Optional |
| max_surge | The number of additional nodes that can be added to the node pool during an upgrade. Increasing max_surge raises the number of nodes that can be upgraded simultaneously. Can be set to 0 or greater. | 1 | Optional |
| max_unavailable | The number of nodes that can be simultaneously unavailable during an upgrade. Increasing max_unavailable raises the number of nodes that can be upgraded in parallel. Can be set to 0 or greater. | 0 | Optional |
| min_count | Minimum number of nodes in the NodePool. Must be >=0 and <= max_count. Should be used when autoscaling is true | 1 | Optional |
| name | The name of the node pool |  | Required |
| node_count | The number of nodes in the nodepool when autoscaling is false. Otherwise defaults to 1. Only valid for non-autoscaling clusers |  | Required |
| node_locations | The list of zones in which the cluster's nodes are located. Nodes must be in the region of their regional cluster or in the same region as their cluster's zone for zonal clusters. Defaults to cluster level node locations if nothing is specified | " " | Optional |
| node_metadata | Options to expose the node metadata to the workload running on the node | | Optional |
| preemptible | A boolean that represents whether or not the underlying node VMs are preemptible | false | Optional |
| sandbox_type | Sandbox to use for pods in the node pool | | Required |
| service_account | The service account to be used by the Node VMs | " " | Optional |
| tags | The list of instance tags applied to all nodes | | Required |
| value | The value for the taint | | Required |
| version | The Kubernetes version for the nodes in this pool. Should only be set if auto_upgrade is false | " " | Optional |



