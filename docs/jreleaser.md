## JReleaser

[JReleaser](https://jreleaser.org/)

## Command

### Jreleaser Assemble (ie Build/Compile)

* Build in [the binaries](../out/go) 
* Create the [archives](../out/jreleaser/assemble/helloworld/archive)

```bash
export JRELEASER_PROJECT_VERSION=0.1.0 # The version to release (mandatory)
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

### JReleaser Release

Create the Github Release:
* with the [changelog](#jreleaser-changelog)
* and [Upload the artifacts](#jreleaser-assemble-ie-buildcompile)
```bash
export JRELEASER_GITHUB_TOKEN=xxxx
jreleaser release
```

### JReleaser Package

Package creation (Docker for now)

```bash
# delete them otherwise Jreleaser will upload/publish all image with the same repo
docker rmi -f $(docker images -q ghcr.io/gerardnico/releasers-go)
jreleaser package
```

### JReleaser Publish (Push Package to registry)

Push Package to the registry
```bash
jreleaser publish
```

### JReleaser GitHub Workflow

[GitHub Actions](https://github.com/features/actions) workflow:
* [release](./.github/workflows/release.yml)
* [early-access.yml](./.github/workflows/early-access.yml) - rolling early-access releases on every push to `main` branch

### Template

https://jreleaser.org/guide/latest/reference/name-templates.html#_project
```gotemplate
{{projectName}}
``` 