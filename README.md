# Preflight
Server testing to run pre-bootstrapping

## Summary
This repo contains simple bash scripts to test that a server meets minimum requirements for the cloudant service to be installed. This is intended to be used by cloudant internally as well as providers to confirm their servers before handing them off to cloudant. 

## Usage
To test a node, execute the appropriate script remotely
```shell
curl -s https://raw.githubusercontent.com/cloudant/preflight/master/softlayer-db.bash | bash
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
