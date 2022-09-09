# OCI Private DNS

## Project description

In this repository, I have documented my hands on experience with Terrafrom for the purpose of OCI Private DNS. This set of HCL based Terraform files which can customized according to any requirements.  

## Topology Diagram 

With the usage of this example HCL code you can build topology documented by diagram below. This topology is extremly simplified for education purposes and rather cannot be used for production implementations. 

![](terraform-oci-private-dns.png)

## How to use code 

### Deploy Using Oracle Resource Manager

1. Click [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/mlinxfeld/terraform-oci-private-dns/releases/latest/download/terraform-oci-private-dns-stack-latest.zip)

    If you aren't already signed in, when prompted, enter the tenancy and user credentials.

2. Review and accept the terms and conditions.

3. Select the region where you want to deploy the stack.

4. Follow the on-screen prompts and instructions to create the stack.

5. After creating the stack, click **Terraform Actions**, and select **Plan**.

6. Wait for the job to be completed, and review the plan.

    To make any changes, return to the Stack Details page, click **Edit Stack**, and make the required changes. Then, run the **Plan** action again.

7. If no further changes are necessary, return to the Stack Details page, click **Terraform Actions**, and select **Apply**. 

### Deploy Using the Terraform CLI

#### STEP 1.

Clone the repo from GitHub.com by executing the command as follows and then go to terraform-oci-private-oke directory:

```
[opc@terraform-server ~]$ git clone https://github.com/mlinxfeld/terraform-oci-private-dns
Cloning into 'terraform-oci-private-dns'...
remote: Enumerating objects: 29, done.
remote: Counting objects: 100% (29/29), done.
remote: Compressing objects: 100% (20/20), done.
remote: Total 29 (delta 9), reused 28 (delta 8), pack-reused 0
Receiving objects: 100% (29/29), 308.42 KiB | 2.27 MiB/s, done.
Resolving deltas: 100% (9/9), done.

[opc@terraform-server ~]$ cd terraform-oci-private-dns/

[opc@terraform-server terraform-oci-private-dns]$ ls -latr

drwxr-xr-x  87 opc  opc   2784 Sep  6 12:20 ..
-rw-r--r--   1 opc  opc    292 Sep  6 12:21 compartment.tf
-rw-r--r--   1 opc  opc    743 Sep  6 12:22 provider.tf
-rw-r--r--   1 opc  opc    244 Sep  6 12:54 locals.tf
-rw-r--r--   1 opc  opc     77 Sep  6 12:55 tls.tf
-rw-r--r--   1 opc  opc   3173 Sep  6 13:05 network.tf
-rw-r--r--   1 opc  opc   1954 Sep  8 10:07 compute.tf
-rw-r--r--   1 opc  opc  19528 Sep  8 10:13 README.md
-rw-r--r--   1 opc  opc   1150 Sep  8 10:15 datasources.tf
-rw-r--r--   1 opc  opc    688 Sep  8 13:02 terraform.tfvars
-rw-r--r--   1 opc  opc    967 Sep  8 13:13 variables.tf
-rw-r--r--   1 opc  opc   2802 Sep  8 13:14 dns.tf
-rw-r--r--   1 opc  opc    675 Sep  8 13:28 outputs.tf
drwxr-xr-x  20 opc  opc    640 Sep  8 14:37 .
```

#### STEP 2.

Within web browser go to URL: https://www.terraform.io/downloads.html. Find your platform and download the latest version of your terraform runtime. Add directory of terraform binary into PATH and check terraform version:

```
[opc@terraform-server terraform-oci-private-dns]$ export PATH=$PATH:/home/opc/terraform

[opc@terraform-server terraform-oci-private-dns]$ terraform --version

Terraform v1.0.0

Your version of Terraform is out of date! The latest version
is 1.2.2. You can update by downloading from https://www.terraform.io/downloads.html
```

#### STEP 3. 
Next create environment file with TF_VARs:

```
[opc@terraform-server terraform-oci-private-dns]$ vi setup_oci_tf_vars.sh
export TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaaob4qbf2(...)uunizjie4his4vgh3jx5jxa"
export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaas(...)krj2s3gdbz7d2heqzzxn7pe64ksbia"
export TF_VAR_compartment_ocid="ocid1.tenancy.oc1..aaaaaaaasbktyckn(...)ldkrj2s3gdbz7d2heqzzxn7pe64ksbia"
export TF_VAR_fingerprint="00:f9:d1:41:bb:57(...)82:47:e6:00"
export TF_VAR_region="eu-frankfurt-1"
export TF_VAR_enable_private_DNS="false"

[opc@terraform-server terraform-oci-private-dns]$ source setup_oci_tf_vars.sh
```

#### STEP 4.
Run *terraform init* with upgrade option just to download the lastest neccesary providers:

```
[opc@terraform-server terraform-oci-private-dns]$ terraform init 

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/null...
- Finding latest version of hashicorp/template...
- Finding latest version of oracle/oci...
- Finding latest version of hashicorp/random...
- Finding latest version of hashicorp/tls...
- Finding latest version of hashicorp/local...
- Installing hashicorp/template v2.2.0...
- Installed hashicorp/template v2.2.0 (signed by HashiCorp)
- Installing oracle/oci v4.84.0...
- Installed oracle/oci v4.84.0 (signed by a HashiCorp partner, key ID 1533A49284137CEB)
- Installing hashicorp/random v3.3.1...
- Installed hashicorp/random v3.3.1 (signed by HashiCorp)
- Installing hashicorp/tls v3.4.0...
- Installed hashicorp/tls v3.4.0 (signed by HashiCorp)
- Installing hashicorp/local v2.2.3...
- Installed hashicorp/local v2.2.3 (signed by HashiCorp)
- Installing hashicorp/null v3.1.1...
- Installed hashicorp/null v3.1.1 (signed by HashiCorp)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

#### STEP 5.
Run *terraform apply* to provision the content of this repo (type **yes** to confirm the the apply phase):

```
[opc@terraform-server terraform-oci-private-dns]$ terraform apply

data.oci_identity_region_subscriptions.home_region_subscriptions: Reading...
data.oci_identity_availability_domains.ADs: Reading...
data.oci_identity_availability_domains.ADs: Read complete after 1s [id=IdentityAvailabilityDomainsDataSource-3269541301]
data.oci_identity_region_subscriptions.home_region_subscriptions: Read complete after 2s [id=IdentityRegionSubscriptionsDataSource-3269541301]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # data.oci_core_images.InstanceImageOCID will be read during apply
  # (config refers to values not yet known)
 <= data "oci_core_images" "InstanceImageOCID" {
      + compartment_id           = (known after apply)
      + id                       = (known after apply)
      + images                   = (known after apply)
      + operating_system         = "Oracle Linux"
      + operating_system_version = "8"
      + shape                    = "VM.Standard.E4.Flex"

      + filter {
          + name   = "display_name"
          + regex  = true
          + values = [
              + "^.*Oracle[^G]*$",
            ]
        }
    }

  # data.oci_core_vcn_dns_resolver_association.FoggyKitchenVCNDNSResolverAssociation[0] will be read during apply
  # (config refers to values not yet known)
 <= data "oci_core_vcn_dns_resolver_association" "FoggyKitchenVCNDNSResolverAssociation" {
      + dns_resolver_id = (known after apply)
      + id              = (known after apply)
      + state           = (known after apply)
      + vcn_id          = (known after apply)
    }

(...)

Terraform will perform the following actions:

(...)

Plan: 16 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + generated_ssh_private_key        = (sensitive value)
  + private_server_dns_name          = "foggykitchenprivateserver.fkdns.me"
  + private_server_ip_address        = (known after apply)
  + public_server_dns_name           = "foggykitchenpublicserver.fkdns.me"
  + public_server_private_ip_address = (known after apply)
  + public_server_public_ip_address  = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

tls_private_key.public_private_key_pair: Creating...
oci_identity_compartment.FoggyKitchenCompartment: Creating...
tls_private_key.public_private_key_pair: Creation complete after 0s [id=1404f79cf998f51a3f2288172b1ce893bca67fb0]
oci_identity_compartment.FoggyKitchenCompartment: Provisioning with 'local-exec'...
oci_identity_compartment.FoggyKitchenCompartment (local-exec): Executing: ["/bin/sh" "-c" "sleep 60"]
oci_identity_compartment.FoggyKitchenCompartment: Still creating... [10s elapsed]
oci_identity_compartment.FoggyKitchenCompartment: Still creating... [20s elapsed]
oci_identity_compartment.FoggyKitchenCompartment: Still creating... [30s elapsed]
oci_identity_compartment.FoggyKitchenCompartment: Still creating... [40s elapsed]
oci_identity_compartment.FoggyKitchenCompartment: Still creating... [50s elapsed]
oci_identity_compartment.FoggyKitchenCompartment: Still creating... [1m0s elapsed]
oci_identity_compartment.FoggyKitchenCompartment: Creation complete after 1m2s [id=ocid1.compartment.oc1..aaaaaaaayxvhhjidfxsq35muvshgxv62ac2mn6mi2yo2xqzsq53jgkuozfwq]
data.oci_dns_resolvers.FoggyKitchenDNSResolvers: Reading...

(...)

Plan: 11 to add, 0 to change, 0 to destroy.

Outputs:

generated_ssh_private_key = <sensitive>
private_server_dns_name = "foggykitchenprivateserver.fkdns.me"
private_server_ip_address = "10.20.20.48"
public_server_dns_name = "foggykitchenpublicserver.fkdns.me"
public_server_private_ip_address = "10.20.10.89"
public_server_public_ip_address = "130.61.150.212"

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

tls_private_key.public_private_key_pair: Creating...
oci_identity_compartment.FoggyKitchenCompartment: Creating...
tls_private_key.public_private_key_pair: Creation complete after 1s [id=ede1cddcaaaaed24abeeb719cfff2eadc17f40da]
oci_identity_compartment.FoggyKitchenCompartment: Provisioning with 'local-exec'...
oci_identity_compartment.FoggyKitchenCompartment (local-exec): Executing: ["/bin/sh" "-c" "sleep 60"]
oci_identity_compartment.FoggyKitchenCompartment: Still creating... [10s elapsed]
oci_identity_compartment.FoggyKitchenCompartment: Still creating... [21s elapsed]

(...)

oci_core_instance.FoggyKitchenPrivateServer: Still creating... [30s elapsed]
oci_core_instance.FoggyKitchenPublicServer: Creation complete after 35s [id=ocid1.instance.oc1.eu-frankfurt-1.antheljsnlc5nbycqr2ldwpqv7r7t5dbdquodv2i3wbuarcnxh3iebcvwq3q]
oci_core_instance.FoggyKitchenPrivateServer: Creation complete after 35s [id=ocid1.instance.oc1.eu-frankfurt-1.antheljsnlc5nbyclcowck5wnb2bsqh36g5ofvnshcwtbagaon7d6v4poqyq]

Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

Outputs:

generated_ssh_private_key = <sensitive>
private_server_dns_name = "foggykitchenprivateserver.fkdns.me"
private_server_ip_address = "10.20.20.143"
public_server_dns_name = "foggykitchenpublicserver.fkdns.me"
public_server_private_ip_address = "10.20.10.238"
public_server_public_ip_address = "130.61.147.55"
```

#### STEP 6. 
Now we need to enable DNS resources (TF_VAR_enable_private_DNS=true) and run terraform apply again:

```
[opc@terraform-server terraform-oci-private-dns]$ export TF_VAR_enable_private_DNS="true"

[opc@terraform-server terraform-oci-private-dns]$ terraform apply -auto-approve
tls_private_key.public_private_key_pair: Refreshing state... [id=ede1cddcaaaaed24abeeb719cfff2eadc17f40da]
data.oci_identity_availability_domains.ADs: Reading...
data.oci_identity_region_subscriptions.home_region_subscriptions: Reading...
data.oci_identity_availability_domains.ADs: Read complete after 1s [id=IdentityAvailabilityDomainsDataSource-3269541301]
data.oci_identity_region_subscriptions.home_region_subscriptions: Read complete after 0s [id=IdentityRegionSubscriptionsDataSource-3269541301]
oci_identity_compartment.FoggyKitchenCompartment: Refreshing state... [id=ocid1.compartment.oc1..aaaaaaaayxvhhjidfxsq35muvshgxv62ac2mn6mi2yo2xqzsq53jgkuozfwq]
oci_core_vcn.FoggyKitchenVCN: Refreshing state... [id=ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaanlc5nbyaitqa3wymdnkd27qotlsszxur52v5dd2dprhsuv5t4eoq]
data.oci_dns_resolvers.FoggyKitchenDNSResolvers: Reading...
data.oci_core_images.InstanceImageOCID: Reading...

(...)

Plan: 5 to add, 0 to change, 0 to destroy.
oci_dns_view.FoggyKitchenDNSView[0]: Creating...
oci_dns_view.FoggyKitchenDNSView[0]: Creation complete after 1s [id=ocid1.dnsview.oc1.eu-frankfurt-1.amaaaaaanlc5nbyabicdvzvw56b4jwh52hk35xyg7tumvvy3ffimzkeg57qa]
oci_dns_resolver.FoggyKitchenDNSResolver[0]: Creating...
oci_dns_zone.FoggyKitchenDNSZone[0]: Creating...
oci_dns_zone.FoggyKitchenDNSZone[0]: Creation complete after 1s [id=ocid1.dns-zone.oc1.eu-frankfurt-1.aaaaaaaa3v6uklr3ja5vfep7nkd4swso6haevpuld2pyobuul3vanfuypyjq]
oci_dns_record.FoggyKitchenDNSPublicServerRecordA[0]: Creating...
oci_dns_record.FoggyKitchenDNSPrivateServerRecordA[0]: Creating...
oci_dns_record.FoggyKitchenDNSPublicServerRecordA[0]: Creation complete after 0s [id=d1c8dfc10d1904eea5f992eaafe5faff]
oci_dns_record.FoggyKitchenDNSPrivateServerRecordA[0]: Creation complete after 1s [id=de024597dc1825442ff7ddb13979ad19]
oci_dns_resolver.FoggyKitchenDNSResolver[0]: Creation complete after 8s [id=ocid1.dnsresolver.oc1.eu-frankfurt-1.amaaaaaanlc5nbyani4t67kt4ffovxxgtbdb5yfgtmhrssvwdgo2fehsyaqq]


Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

generated_ssh_private_key = <sensitive>
private_server_dns_name = "foggykitchenprivateserver.fkdns.me"
private_server_ip_address = "10.20.20.143"
public_server_dns_name = "foggykitchenpublicserver.fkdns.me"
public_server_private_ip_address = "10.20.10.238"
public_server_public_ip_address = "130.61.147.55"
```

#### STEP 7.
Now you can access you public server and ping DNS names of public one and private one. But first you need to download generated private key:

```
[opc@terraform-server terraform-oci-private-dns]$ terraform console
> nonsensitive(tls_private_key.public_private_key_pair.private_key_pem)
<<EOT
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEA6Y6/zoTzIHCMFrvDwc4kFLhQYHI/73+qkoVV1xnIebcwkIo0
PFlEc+hAI4sj1nIPH4f+QujxfKkzS8rsiGKrzkvecZ1HOvxcCWNc3BpERcjXv5r3
KFJiUIFBjcMkH1hjAWboiAH+WIkYlZjLBz+7g5lGo6MIL9DrPk/YlnDZfdvOSiCx
(...)
gBLmIAbyzekMTartsNeEkBiaxbw4G/s3U9vrJlNAimTLIdv7LmBXFclhFO86wG04
ARZjpJ8CgYEAv70a9I7oaMz72Q57QfgGPerQd3pfS37cBAERRtl8VSHpEmxKNBgN
ikS9t/c4yBfwLhSqsCjJDlUktwJYxLwrECytIovCe2En45qXIqeM3wW+PliOwWbq
41W0RkX6etXMf9HCT3V4LNQie6yjCyzN9XWlalSjBOQRNS15zMYXkmo=
-----END RSA PRIVATE KEY-----

EOT


[opc@terraform-server terraform-oci-private-dns]$ vi id_rsa

[opc@terraform-server terraform-oci-private-dns]$ chmod 400 id_rsa


[opc@terraform-server terraform-oci-private-dns]$ scp -i id_rsa id_rsa opc@130.61.147.55:/home/opc/
The authenticity of host '130.61.147.55 (130.61.147.55)' can't be established.
ED25519 key fingerprint is SHA256:HCfma1NaiYcJIzpLSS+DOpkT2PQHOk3FWppUSspA1Ms.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '130.61.147.55' (ED25519) to the list of known hosts.

id_rsa               100% 1679    48.4KB/s   00:00

[opc@terraform-server terraform-oci-private-dns]$ ssh -i id_rsa opc@130.61.147.55

Activate the web console with: systemctl enable --now cockpit.socket

Last login: Fri Sep  9 12:29:03 2022 from 89.64.90.185

[opc@foggykitchenpublicserver ~]$ ping foggykitchenpublicserver.fkdns.me

PING foggykitchenpublicserver.fkdns.me (10.20.10.238) 56(84) bytes of data.
64 bytes from foggykitchenpublicserver.pubsub.fkvcn.oraclevcn.com (10.20.10.238): icmp_seq=1 ttl=64 time=0.037 ms
64 bytes from foggykitchenpublicserver.pubsub.fkvcn.oraclevcn.com (10.20.10.238): icmp_seq=2 ttl=64 time=0.047 ms
^C
--- foggykitchenpublicserver.fkdns.me ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1023ms
rtt min/avg/max/mdev = 0.037/0.042/0.047/0.005 ms

[opc@foggykitchenpublicserver ~]$ ssh -i id_rsa opc@foggykitchenprivateserver.fkdns.me

The authenticity of host 'foggykitchenprivateserver.fkdns.me (10.20.20.143)' can't be established.
ECDSA key fingerprint is SHA256:8cS7+RRvpPEAgBwqEERddtgMx9ujCmhleuN3KgLfbyg.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'foggykitchenprivateserver.fkdns.me,10.20.20.143' (ECDSA) to the list of known hosts.
Activate the web console with: systemctl enable --now cockpit.socket

[opc@foggykitchenprivateserver ~]$ exit
logout
Connection to foggykitchenprivateserver.fkdns.me closed.
[opc@foggykitchenpublicserver ~]$ exit
logout
Connection to 130.61.147.55 closed.

```

#### STEP 8.
After testing the environment you can remove the OCI OKE infra. You should just run *terraform destroy* (type **yes** for confirmation of the destroy phase):

```
[opc@terraform-server terraform-oci-private-dns]$ terraform destroy -auto-approve

tls_private_key.public_private_key_pair: Refreshing state... [id=ede1cddcaaaaed24abeeb719cfff2eadc17f40da]
data.oci_identity_availability_domains.ADs: Reading...
data.oci_identity_region_subscriptions.home_region_subscriptions: Reading...
data.oci_identity_availability_domains.ADs: Read complete after 2s [id=IdentityAvailabilityDomainsDataSource-3269541301]
data.oci_identity_region_subscriptions.home_region_subscriptions: Read complete after 1s [id=IdentityRegionSubscriptionsDataSource-3269541301]
oci_identity_compartment.FoggyKitchenCompartment: Refreshing state... [id=ocid1.compartment.oc1..aaaaaaaayxvhhjidfxsq35muvshgxv62ac2mn6mi2yo2xqzsq53jgkuozfwq]
data.oci_dns_resolvers.FoggyKitchenDNSResolvers: Reading...
oci_dns_view.FoggyKitchenDNSView[0]: Refreshing state... [id=ocid1.dnsview.oc1.eu-frankfurt-1.amaaaaaanlc5nbyabicdvzvw56b4jwh52hk35xyg7tumvvy3ffimzkeg57qa]
oci_core_vcn.FoggyKitchenVCN: Refreshing state... [id=ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaanlc5nbyaitqa3wymdnkd27qotlsszxur52v5dd2dprhsuv5t4eoq]
data.oci_core_images.InstanceImageOCID: Reading...

(...)

oci_core_internet_gateway.FoggyKitchenInternetGateway: Destroying... [id=ocid1.internetgateway.oc1.eu-frankfurt-1.aaaaaaaajvkm2ylrbbonytwuoum4cmm5ohhop4nsj7udmzfcvm74pnzymqda]
oci_core_internet_gateway.FoggyKitchenInternetGateway: Destruction complete after 1s
oci_core_vcn.FoggyKitchenVCN: Destroying... [id=ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaanlc5nbyaitqa3wymdnkd27qotlsszxur52v5dd2dprhsuv5t4eoq]
oci_core_vcn.FoggyKitchenVCN: Destruction complete after 1s
oci_identity_compartment.FoggyKitchenCompartment: Destroying... [id=ocid1.compartment.oc1..aaaaaaaayxvhhjidfxsq35muvshgxv62ac2mn6mi2yo2xqzsq53jgkuozfwq]
oci_identity_compartment.FoggyKitchenCompartment: Destruction complete after 0s

Destroy complete! Resources: 16 destroyed.
```
