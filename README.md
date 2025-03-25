# 1001 ways to release a Go application

This repository release the [helloworld go app](src/helloworld.go) with

* [JReleaser](docs/jreleaser.md)
* [GoReleaser](docs/goreleaser.md)

## Support
### Git: Rejected - would clobber existing tag
Because release may create tags, you can get this error while fetching

To force:
```bash
git fetch --tags --force
```
