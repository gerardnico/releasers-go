

## Version 

### Tag

GoReleaser will use the latest Git tag of your repository.
```bash
git tag -a v0.1.0 -m "First release"
git push origin v0.1.0
```
 
### Snapshot

use the `--snapshot`
```bash
goreleaser release --snapshot
```

## Command
### Local release

```bash
goreleaser release --snapshot --clean
```

### Check Config
You can verify your .goreleaser.yaml is valid by running the check command:
```bash
goreleaser check
```

### Build Single target

```bash
GOOS="linux" \
GOARCH="arm64" \
  goreleaser build --single-target
```