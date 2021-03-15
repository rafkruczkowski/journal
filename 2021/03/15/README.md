# Kubernetes version 1.20
2021/03/15 Monday
---
[Based on release notes for 1.20](https://kubernetes.io/docs/setup/release/notes/#changelog-since-v1-19-0)

## Major Updates

### Docker deprecation
Docker driver now replaced with Open Source OCI - Open Container Initative

### External credential for client-go
New AAA values for Go

### Updates to a new CronJob
New way to do Cron

### Limits to number of PIDs
New method to limit number of PIDs

### API Priority and Fairness
Allows for incoming API calls to be set a QoS policy

### IPv4/IPv6
Support for dual stack

### Go 1.15.5

### CIS Volume Snapshots
Support for snapshots for volumes

### FSGroup Volume Ownership permission
Support for non-recursive volume ownership

### CSIDriver for FSGroup
Permission setting for FSGroup

### Support for CSI Drivers
Allows for volume impersonation to test features

### Graceful Node Shutdown
New API call to signal a pod to shutdown

### Runtime log sanitation
Filter logs for sensitive values

### Pod Resource Metrics

### RootCAConfigMap
For mapping certificates to the CA

### kubectl debug
Support for new debugging command

### Pod hostname as FQDN

### Cloud Controller Manager no longer included
To be provided by the Cloud themselves

## Known Issues

### API Summary not working in some states

## Upgrade Caveat

### ExecProbeTimeout may not work

### API calls changed

### API Priority changed
So servers with APF tunned should not work together with 1.19 and 1.20

### CIS Drivers need to do their own checks

### Kubeadm changes
#### control-plane label changed
#### Taint for master is changed

### Dual Stack will change the way API works

---
[Link to ToC](https://github.com/rafkruczkowski/journal)