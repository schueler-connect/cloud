variable "hcloud_token" {
	type = string
	sensitive = true
}

module "kube-hetzner" {
  source  = "kube-hetzner/kube-hetzner/hcloud"

	hcloud_token = var.hcloud_token

	public_key = "../misc/ssh-hk-cluster.pub"
	private_key = "../misc/ssh-hk-cluster"

	network_region = "eu-central" # change to `us-east` if location is ash

  control_plane_nodepools = [
    {
      name        = "control-plane-nbg1",
      server_type = "cpx11",
      location    = "nbg1",
      labels      = [],
      taints      = [],
      count       = 3
    },
  ]

  agent_nodepools = [
    {
      name        = "agent-large",
      server_type = "cpx21",
      location    = "nbg1",
      labels      = [],
      taints      = [],
      count       = 2
    },
  ]

  load_balancer_type     = "lb11"
  load_balancer_location = "nbg1"
}
