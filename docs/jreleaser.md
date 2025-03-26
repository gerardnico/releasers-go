## JReleaser

[JReleaser](https://jreleaser.org/)





## Concept

### Version

The version (ie the id) of the release is mandatory

* Manual
```bash
export JRELEASER_PROJECT_VERSION=0.1.0
```
* Automatic with git-cliff of any other changelog conventional commit parser
```bash
export JRELEASER_PROJECT_VERSION=$(git cliff --bumped-version)
```

### Distribution

The distribution has:
* a type (BINARY, ...)
* a list of all artifacts
* a list of packagers configuration
* and a platform


```bash
jreleaser config
```

### Platform

Platform is a mix of os and arch.

It's added as property of
* the artifacts (distribution.artifacts)
* the distribution


### Template

https://jreleaser.org/guide/latest/reference/name-templates.html#_project
```gotemplate
{{projectName}}
```

## Command

* `config`: [Check and create the config](#jreleaser-config)
* `changelog`: [create a changelog](#jreleaser-changelog)
* `assemble`: [create build artifact (ie build + archive)](#jreleaser-assemble-ie-buildcompile)
* `release`: create a release in a git hosting service (ie changelog + build artifact) and create a tag [release](#jreleaser-release)
* `package`: create a package (ie docker, homebrew)
* `publish`: publish the packages to a registry

### JReleaser Config

Check the actual values and the generated one with:
```bash
jreleaser config --full
```

### Jreleaser Assemble (ie Build/Compile)

* Build in [the binaries](../out/go) 
* Create the [archives](../out/jreleaser/assemble/helloworld/archive)

```bash 
jreleaser assemble
```

This command will:

* compile a helloworld app for the following targets:
  ** `linux-amd64`
  ** `linux-arm64`
  ** `darwin-arm64`
  ** `darwin-amd64`
  ** `windows-amd64`
  ** `windows-arm64`
* assemble zip distributions with JReleaser

### JReleaser ChangeLog

Change log creation
```bash
jreleaser changelog
```
Generated at `out/jreleaser/release/CHANGELOG.md`

Can be [externally generated](https://jreleaser.org/guide/latest/reference/release/changelog.html#_external_changelog)
```yaml
release:
  github:
    changelog:
      external: partial-changelog.md
```

### JReleaser Release

Create the Github Release:
* with the [changelog](#jreleaser-changelog)
* and [Upload the artifacts](#jreleaser-assemble-ie-buildcompile)
```bash
export JRELEASER_GITHUB_TOKEN=xxxx
jreleaser release
```

### JReleaser Docker Packager

You can set docker configuration in 2 place:
* under packagers for one (the first platform by name??)
* and [distribution for multiple images](https://jreleaser.org/guide/latest/reference/packagers/docker.html#_multiple_dockerfile_per_distribution)


Steps:

* delete them otherwise Jreleaser will upload/publish all image with the same repo
```bash
docker rmi -f $(docker images -q ghcr.io/gerardnico/releasers-go)
```
```bash
jreleaser package
```

The following labels are added, not `LABEL org.opencontainers.image.source https://github.com/OWNER/REPO` unfortunately
```yaml
 labels:
   org.opencontainers.image.title: {{distributionName}}
   org.opencontainers.image.description: {{projectDescription}}
   org.opencontainers.image.url: {{projectWebsite}}
   org.opencontainers.image.licenses: {{projectLicense}}
   org.opencontainers.image.version: {{projectVersion}}
   org.opencontainers.image.revision: {{commitFullHash}}
```

### JReleaser Publish (Push Package to registry)

Push Package to the registry
```bash
jreleaser publish
```

## GitHub Workflow

[GitHub Actions](https://github.com/features/actions) workflow:
* [release](./.github/workflows/release.yml)
* [early-access.yml](./.github/workflows/early-access.yml) - rolling early-access releases on every push to `main` branch

 