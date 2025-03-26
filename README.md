# 1001 ways to release a Go application

This repository showcase the release of an [helloworld go app](src/helloworld.go) with
different tools.

## Env Installation

### Direnv

If you use [direnv](https://direnv.net/), it will execute [.envrc](./.envrc)
otherwise you need to execute it yourself
```bash
source .envrc
```

### Nix
If you use [nix](https://nix.dev/), the release and devtools will be available in your shell.

## Release Tools
### JReleaser
[JReleaser](docs/jreleaser.md)

From a version, it will:
* create a git tag by default (`skipTag: false`)
* perform the whole release process

```bash
export JRELEASER_PROJECT_VERSION=0.1.0-jreleaser
jrelease publish
# or for a more advanced script
task jr-release
```

### GoReleaser

[GoReleaser](docs/goreleaser.md) release from the last tag.

It expects:
* you to create the tag with a semantic version
* to be on the same commit without a dirty repository

```bash
git tag -a v0.1.1-goreleaser -m "build: go releaser clean"
# --skip=validate to avoid the error: git is in a dirty state
goreleaser release --clean --skip=validate
```

### Ko

[Ko](docs/ko.md) - go docker release only

```bash
task ko-build 
```

## Packaging
### Nix Packaging

An experiment to create a [build nix script](build.nix)

```bash
task nix-build
```

Note: 
* Nix seems to build for the current os/arch. 
* As nix is a packager, we need to path it the build artifacts or source and not the current path.

### Docker

* [ko](docs/ko.md)
* [jReleaser](docs/jreleaser.md#jreleaser-docker-packager) uses a default docker template or your can pass [your own](.jreleaser/docker/Dockerfile.tpl)


## Changelog Tools

### Commitlint

We use commitlint to check the [commit message](.git-hooks/commit-msg)
so that Changelog generation tools can parse them.

### Git Cliff - Changelog generation

[GitCliff](https://git-cliff.org/) is a changelog tool generator.

It has the advantage over releasers tool to be able to determine the next version automatically.
```bash
export NEW_VERSION=$(git cliff --bumped-version);
```

### JReleaser Changelog

See [jreleaser-changelog](docs/jreleaser.md#jreleaser-changelog)

### GoReleaser Changelog

See [goreleaser changelog](docs/goreleaser.md#changelog)

### Github Changelog

GitHub offers an option to [generate release notes](https://docs.github.com/en/repositories/releasing-projects-on-github/automatically-generated-release-notes).

JReleaser supports it.

## Commands

The commands are in [TaskFile](Taskfile.yml) from [GoTask](https://github.com/go-task/task)


## Support
### Git: Rejected - would clobber existing tag
Because release tools may create tags, you can get this error while fetching

To force:
```bash
git fetch --tags --force
```

