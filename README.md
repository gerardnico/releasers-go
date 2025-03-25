# 1001 ways to release a Go application

This repository release the [helloworld go app](src/helloworld.go)

* via [JReleaser](docs/jreleaser.md)

## Support
### Git: Rejected - would clobber existing tag
Because release may create tags, you can get this error while fetching

To force:
```bash
git fetch --tags --force
```