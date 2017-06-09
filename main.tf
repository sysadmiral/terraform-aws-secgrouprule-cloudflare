data "http" "cloudflare_ipv4" {
  url = "https://www.cloudflare.com/ips-v4"
}

data "http" "cloudflare_ipv6" {
  url = "https://www.cloudflare.com/ips-v6"
}

resource "aws_security_group_rule" "cloudflare_to_http" {
  count             = "${var.enable_http ? 1 : 0}"
  type              = "ingress"
  to_port           = 80
  from_port         = 80
  protocol          = "-1"
  cidr_blocks       = ["${split("\n",trimspace(data.http.cloudflare_ipv4.body))}"]
  ipv6_cidr_blocks  = ["${split("\n",trimspace(data.http.cloudflare_ipv6.body))}"]
  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "cloudflare_to_https" {
  count             = "${var.enable_https ? 1 : 0}"
  type              = "ingress"
  to_port           = 443
  from_port         = 443
  protocol          = "-1"
  cidr_blocks       = ["${split("\n",trimspace(data.http.cloudflare_ipv4.body))}"]
  ipv6_cidr_blocks  = ["${split("\n",trimspace(data.http.cloudflare_ipv6.body))}"]
  security_group_id = "${var.security_group_id}"
}
