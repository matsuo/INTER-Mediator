# INTER-Mediator End-To-End Test with WebdriverIO

Installation and starting tests are below. The last command can the end-to-end test with WebdriverIO.
```
cd spec/run
pnpm install --frozen-lockfile
pnpm run wdio
```
After setup with the command ```pnpm install --frozen-lockfile```, you can test with this command on the root of this repository:
```
composer wdio-test
```

Also refer to the GitHub Action at /.github/workflows/php.yml.

The samples/E2E-Test directory has the target pages for these tests.

## Other commands

Just run the test with Google Chrome

```
pnpm run wdio wdio-auth-chrome.conf.js 
```

Just run the test with Microsoft Edge

```
pnpm run wdio wdio-form-edge.conf.js 
```

Just run the test with Firefox

```
pnpm run wdio wdio-auth-firefox.conf.js 
```

Just run the test with Safari. This test works on the /spec/run-safari directory.

```
cd /spec/run-safari
pnpm run wdio wdio-safari.conf.js 
```

Another syncing between clients test.

```
pnpm run wdio wdio-sync-chrome.conf.jp
```

