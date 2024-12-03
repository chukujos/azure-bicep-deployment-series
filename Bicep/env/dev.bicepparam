using '../main.bicep'

param deploySSHParam = true

param resourceGroupEUSParam = {
  name: 'demo'
  location: 'eastus'
}

param tagsParam = {
  owner: 'Josiah'
  workload: 'agentpool'
  application: 'azureDevOps'
  env: 'lab'
}

param vnetParam = {
  name: 'agentpool-vnet'
  subnetName: 'default'
  addressPrefix: '10.0.0.0/16'
  subnetAddressPrefix: '10.0.2.0/24'
}

param vmParam = {
  name: 'agentpool-vm'
  size: 'Standard_D2s_v3'
  imageReference: {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-focal'
    sku: '20_04-lts-gen2'
    version: 'latest'
  }
  adminUsername: 'agentpool'
  sshPublicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmtZWE2YLzHPoZunxecxfc+AtDEKqLUGkT+MnkeKPjNp19r5JdMaeqTqyCCL9DZXLnA6mb1e3SMcaue2o45DxLuOadFUEhsc2czK5X22DCzgxTwk//JoUuvHN1GIMSafWFO6zeUKju+FmNb9iT2Ib3GW9ZPKxe5XLDYOrn6XxWNeMMMgkumAqeZ6tuqUTTfgPxdcD69tXZLto58VpMauQSCFn9cKBGxjbCT0dgL5tGoURkdIZ0/54Di/azG3fPDMuIUAlz3KcE701RXfrKPthzWs9wVi53zsDhUO+DEmusUZ+E/Y92Y+ApJIN9j8FogeR+NkhbSDBfFqVBqmhp6+MRrXN7cvvebQUzOMkNS0m8q07JV+cytp1JpZdlCSPgDKRctDXw+5gbC5333Aua6rUaAbB01Si/TocPbmDl1WahKD+MrjC0K8y38Od9F139kXBlyHlsRwHtC7m7WTTx31MGIWIF/MMKPqiig0Y1ZsiuLuz7bEyZGJG6Od64XvSvr2rSeoOO7GKAsCtE+LZnwYZfOg+zO4QJpyLQUIYCS/mIWoZrriUW/kID2fQ/Fz0GA8XYS6OcOq25/UyhFKo34+xyd3U7llqVsaEnef19Pu+2Tjs3ULZDuRhTYAk9uovHCVZ3uO2cRBgxndLFM8YFv65/fxUCNLhNKw4FsLWIBYlaTQ== Ihean@Chukwu'
}

