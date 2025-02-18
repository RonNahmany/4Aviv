oauth2_permission_scopes = [
  {
    admin_consent_description  = "Allow the application to Update Application Data on behalf of the signed-in admin."
    admin_consent_display_name = "Update Application Data"
    enabled                    = true
    id                         = "96183846-204b-4b43-82e1-5d2222eb4b9b"
    type                       = "Admin"
    value                      = "LegalEntities.ReadWrite"
  },
  {
    admin_consent_description  = "Allow the application to Read Application Data on behalf of the signed-in users"
    admin_consent_display_name = "Read Application Data"
    enabled                    = true
    id                         = "be98fa3e-ab5b-4b11-83d9-04ba2b7946bc"
    type                       = "Admin"
    value                      = "LegalEntities.Read"
  }
]

app_roles = [
  {
    allowed_member_types = ["User"]
    description          = "Enables user to access legal entities platform"
    display_name         = "LegalEntities.User"
    enabled              = true
    id                   = "d1c7634b-6c9d-4c3a-b73b-66e5b3b34b7f"
    value                = "LegalEntities.User"
  },
  {
    allowed_member_types = ["User"]
    description          = "Allow admins to manage the application"
    display_name         = "LegalEntities.Admin"
    enabled              = true
    id                   = "a3bb189e-8bf9-3888-9912-555555555555"
    value                = "LegalEntities.Admin"
  },
  {
    allowed_member_types = ["User"]
    description          = "Allow the app to read legal entities data using the web api"
    display_name         = "LegalEntities.Viewer"
    enabled              = true
    id                   = "c9e1074f-5b93-4b16-a7f2-4c9d1db87f6a"
    value                = "LegalEntities.Viewer"
  },
  {
    allowed_member_types = ["User"]
    description          = "Allow the app to write legal entities data using the web api"
    display_name         = "LegalEntities.Editor"
    enabled              = true
    id                   = "d9b2d63d-3b15-4d78-b62b-5f1f8e905d29"
    value                = "LegalEntities.Editor"
  }
]

required_resource_access = [
  {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph
    resource_access = [
      {
        id   = "b340eb25-3456-403f-be2f-af7a0d370277" # User.ReadBasic.All
        type = "Scope"
      },
      {
        id   = "37f7f235-527c-4136-accd-4a02d197296e" # openid
        type = "Scope"
      },
      {
        id   = "7427e0e9-2fba-42fe-b0c0-848c9e6a8182" # offline_access
        type = "Scope"
      }
    ]
  }
]

required_resource_access_app1 = [
  {
    id   = "96183846-204b-4b43-82e1-5d2222eb4b9b" 
    type = "Scope"
  },
  {
    id   = "be98fa3e-ab5b-4b11-83d9-04ba2b7946bc" 
    type = "Scope"
  }
]


network_rules = {
  default_action = "Deny"
  bypass         = ["AzureServices"]
  ip_rules = [
    "20.76.239.223",
    "20.76.232.26",
    "20.86.251.186",
    "20.86.251.187",
    "20.86.249.112",
    "20.86.248.110",
    "84.108.115.137",
    "84.108.115.136",
    "20.50.2.70",
    "20.190.128.0",
    "24.57.77.3",
    "35.187.57.100",
    "35.195.39.13",
    "35.205.48.209"
  ]
}




csm_addresses_allow = [
  "84.108.115.137/32",
  "84.108.115.136/32",
  "24.57.77.3/32",
]

ip_addresses_allow = [
  "20.76.26.34/32",
  "20.76.26.66/32",
  "20.76.26.77/32",
  "20.73.201.59/32",
  "20.76.26.138/32",
  "20.73.204.56/32",
  "20.50.2.36/32",

  "35.187.57.100/32",
  "35.195.39.13/32",
  "35.205.48.209/32",
  "84.108.115.137/32",
  "84.108.115.136/32",
  "24.57.77.3/32",
  "20.190.128.0/18",
]

username = "legalentsv0532"
rg_prefix_name = "legalent-resource-group"
applicationname = "legal-application"