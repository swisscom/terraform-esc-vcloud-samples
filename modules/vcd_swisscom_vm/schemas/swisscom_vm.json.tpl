{
  "template": {
    "templateUrl": "${templateHref}",
    "templateName": ""
  },
  "description": "${description}",
  "status": "",
  "administratorRootPassword": "${password}",
  "technicalContactEmail": "admin@admin.com",
  "cpus": 2,
  "coresPerSocket": 1,
  "memoryMb": 2048,
  "owner": {
    "urn": "${userUrn}",
    "username": "${userName}"
  },
  "backup": {
    "backup": "Disable",
    "friendlyPolicyName": "",
    "policyName": "",
    "replication": false
  },
  "virtualDataCenter": {
    "id": "${vdcId}",
    "name": "${vdcName}"
  },
  "organization": {
    "name": "${orgName}",
    "id": "${orgId}"
  },
  "serviceLevel": "${serviceLevel}",
  "location": {
    "location": "${location}",
    "locationConstraint": "${locationConstraint}"
  },
  "powerOn": true,
  "nativeVM": false,
  "migratedVM": false,
  "isManagedOs": false,
  "os": "rhel",
  "networkEntries": [
    {
      "index": 0,
      "network": "${network}",
      "dhcpEnabled": false,
      "ipAddress": ""
    }
  ],
  "storageEntries": [
    {
      "index": 0,
      "storageMB": 35840,
      "diskLvName": "Disk 0",
      "fileSystemMount": "Hard Disk 1",
      "storagePolicy": "${storagePolicy}",
      "type": "5"
    },
    {
      "index": 1,
      "storageMB": 10240,
      "diskLvName": "Disk 1",
      "fileSystemMount": "Hard Disk 2",
      "storagePolicy": "${storagePolicy}",
      "type": "5"
    },
  "customInputs": [],
  "providerCustomInputs": []
  ]
}