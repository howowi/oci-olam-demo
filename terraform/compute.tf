provider "oci" {}

resource "oci_core_instance" "webserver" {
	agent_config {
		is_management_disabled = "false"
		is_monitoring_disabled = "false"
		plugins_config {
			desired_state = "DISABLED"
			name = "Vulnerability Scanning"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Oracle Java Management Service"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "OS Management Service Agent"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "OS Management Hub Agent"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Management Agent"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Custom Logs Monitoring"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Compute RDMA GPU Monitoring"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Run Command"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Monitoring"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Compute HPC RDMA Auto-Configuration"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Compute HPC RDMA Authentication"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Cloud Guard Workload Protection"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Block Volume Management"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Bastion"
		}
	}
	availability_config {
		is_live_migration_preferred = "true"
		recovery_action = "RESTORE_INSTANCE"
	}
	availability_domain = "uNUN:AP-SINGAPORE-1-AD-1"
	compartment_id = "ocid1.compartment.oc1..aaaaaaaaq7p73lsppw3gidxr6djfbzlrpx3yrhll5ft7q3hd5r6dalox466a"
	create_vnic_details {
		assign_ipv6ip = "false"
		assign_private_dns_record = "true"
		assign_public_ip = "true"
		subnet_id = "ocid1.subnet.oc1.ap-singapore-1.aaaaaaaaeurxq4fmoawmti3hbxdlfk7ey6ijo3xgbnidbk3c4rvaapwmqhka"
	}
	display_name = "webserver"
	instance_options {
		are_legacy_imds_endpoints_disabled = "false"
	}
	metadata = {
		"ssh_authorized_keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDP5N8IWBmMDHjVBbyURNmTW6/IBOmPK25u+kgVxkvLpRs1m4Rd6EHJOQVmq8aYeBbb6oivIlLLH2OHxLIaheGeAsJJ4QkjI3EahfpQjHGoQcmLUeaQcDqn4ZCfdmAINj/EOScHGtnf7qu+dEAmJg/+hCy5QjmqUGjrkT4Xqj38b9s59fQlh0kI/xdljirLKOD5Ppl8f1v3bZyloz4sqTMXXaB8hX02aTd35QIyaA8RiasuJx6w0TptOiuAzo530ETlHt6iw4UP1uMS2Cwuwi4ihhD4Ocw1JdfRQ+v41nhgEiZnRhT7xiV7NnUAg03iM0FSfSnjYLEElxDGVS1WrEmlBqOmL0U3jXfb1hapLSsWZhHY2W6dgYmQ9HQGvGYbqvmmJPXzmMq3NjO00mF77Lfj5yI3+y26FV5ubLeqwUg6VSItJktpYleqBndVb/DwsB5mVUvMNY6Xc4ZJHVTwQRr5pzVNIXCs3z7ZqvW2EYgU402vblwGAePxtZiKodYwLNSuwcHfN3Hg8KwfFpclUAg3CB+qXyC6uosGfPPLCpp/WkHMgFjynPuZ4QU97NWDSaSnhpcVVZYaBjrJvoKpRHJEbYFsd4xFBkqC0eEISz7qeqXnmN24cIfW3XSmTl/EvvGNG9aLrk33GRMy3i3x/+BPH6DmUPumN84Wh99GSv05MQ== howie-owi@howie-owi-mac"
	}
	platform_config {
		is_symmetric_multi_threading_enabled = "true"
		type = "AMD_VM"
	}
	shape = "VM.Standard.E4.Flex"
	shape_config {
		baseline_ocpu_utilization = "BASELINE_1_1"
		memory_in_gbs = "4"
		ocpus = "1"
	}
	source_details {
		boot_volume_size_in_gbs = "50"
		boot_volume_vpus_per_gb = "10"
		source_id = "ocid1.image.oc1.ap-singapore-1.aaaaaaaaudaszcmpcqnioqe7o66d2k3jgq6muj26ykupd2lbvik4rwmo7e6a"
		source_type = "image"
	}
}
