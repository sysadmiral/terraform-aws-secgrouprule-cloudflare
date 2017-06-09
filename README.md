# sysadmiral_tf_aws_secgrouprule_cloudflare
Allow traffic from cloudflare to your origin by including this module

## what this module does
The module pulls the ip4 and ip6 addresses from the public plaintext location
that cloudflare kindly make available [here][1] and [here][2] into the terraform
data_source "http" introduced in [0.9.5][3].

The data is used to allow access from those ips to your origin on port 80 or 443
using a boolean var to apply the rule.

## usage
Define a security group for your app/load balancer and call this module and pass
the security group ID to the module.

```
resource "aws_security_group" "myapp" {

}

module "sysadmiral_tf_aws_secgrouprule_cloudflare" {
  source            = "github.com/sysadmiral/sysadmiral_tf_aws_secgrouprule_cloudflare"
  security_group_id = "${aws_security_group.myapp.id}"
  enable_http       = false
  enable_https      = true
}
```

[1]: https://www.cloudflare.com/ips-v4 "ip4 addresses"
[2]: https://www.cloudflare.com/ips-v6 "ip6 addresses"
[3]: https://github.com/hashicorp/terraform/blob/v0.9.5/CHANGELOG.md "0.9.5 changelog"
