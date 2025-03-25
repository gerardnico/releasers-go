

## Version 

### Tag

GoReleaser will use the latest Git tag of your repository.
```bash
git tag -a v0.1.0 -m "First release"
git push origin v0.1.0
```

Custom: https://goreleaser.com/cookbooks/set-a-custom-git-tag/
 
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

### Release

Release is done against a tag and the current commit should be this tag

```bash
# commit and tag
git tag -a v0.1.1-goreleaser -m "build: go releaser clean"
#git push origin v0.1.0
goreleaser release
```

### Build Single target

```bash
GOOS="linux" \
GOARCH="arm64" \
  goreleaser build --single-target
```

## Support

### git tag was not made against

You tagged and commit after that, so your current commit is 04c9631
but that is not the commit at which the tag was made.