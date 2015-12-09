# Kitchen::Driver::Sakuracloud



```
---
driver:
  name: sakuracloud
  api_token: API_TOKEN (or from env => SAKURACLOUD_API_TOKEN )
  api_token_secret: API_TOKEN_SECRET (or from env => SAKURACLOUD_API_TOKEN_SECRET )
  sshkey_id: 11260xxxx (or from env => SAKURACLOUD_SSH_KEYID )
  serverplan: 1001
  diskplan: 4
  size_mb: 20480
  api_zone: tk1a

transport:
  username: root
  ssh_key: ~/.ssh/path_to_keyfile

provisioner:
  name: shell

verifier:
  name: shell

platforms:
  - name: ubuntu-14.04
    driver:
      sourcearchive: 112700955889
    transport:
      username: ubuntu

suites:
  - name: default
    run_list:
    attributes:
```
