provider "vsphere" {
	user		= "administrator@vsphere.local"
	password	= "nopass"
	vsphere_server	= "10.80.100.14"

	allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
	name = "tf1"
}

data "vsphere_resource_pool" "pool" {
	name = "terraform"
	datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "datastore" {
	name		= "datastore3"
	datacenter_id	= "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
	name		= "VMdev"
	datacenter_id	= "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
	name		= "terraform"
	datastore_id	= "${data.vsphere_datastore.datastore.id}"
	resource_pool_id = "${data.vsphere_resource_pool.pool.id}"

	num_cpus = 1
	memory	 = 1024
	guest_id = "ubuntu64Guest"

	network_interface {
		network_id = "${data.vsphere_network.network.id}"
	}

	disk {
		label = "disk0"
		size = 16
	}

}
