# Code Source
https://github.com/cloudant/preflight

# Preflight
Server testing to run pre-bootstrapping

## Summary
This repo contains simple bash scripts to test that a server meets minimum requirements for the EHaaS service to be installed. This is intended to be used by EHaaS internally as well as providers to confirm their servers before handing them off to EHaaS. 

## Usage
To test a node, execute the appropriate script remotely
```shell
curl -s https://raw.githubusercontent.com/ehaas-cds/preflight/master/ehaas_compute_small.bash | bash
```

Alternative way is to download the entire script folder as zip and execute it locally
```shell
cd /tmp
wget https://github.com/ehaas-cds/preflight/archive/master.zip
unzip master.zip
cd preflight-master/
bash ehaas_compute_small.bash
```

## Writing Tests
 * All tests should be written in bash and put in the `tests` directory. 
 * Try not to make assumptions about the system the test will be run on and be flexible in its writing.
 * Create a function called `preflight_test` which will be called to run your test_

### Example

```shell
preflight_test () {
    # write test code here
}
```
