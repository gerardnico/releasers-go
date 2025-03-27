# Ko


Builds and pushes a container image, and prints the resulting image digest to stdout.


```bash
KO_DOCKER_REPO=ghcr.io/gerardnico/mail-checker
GOFLAGS="-ldflags=-X=main.version=$JRELEASER_PROJECT_VERSION" ko build . \
  --image-label org.opencontainers.image.source=https://github.com/gerardnico/mail-checker \
  --image-label org.opencontainers.image.description=MailChecker \
  --image-label org.opencontainers.image.title=MailChecker \
  --image-label org.opencontainers.image.authors=Nico \
  --image-label org.opencontainers.image.url=https://github.com/gerardnico/mail-checker \
  --image-label org.opencontainers.image.licenses=MIT \
  --image-label org.opencontainers.image.version=$JRELEASER_PROJECT_VERSION \
  --bare \
  --tags v"$JRELEASER_PROJECT_VERSION"
```
where the options
* `--bare` omit the md5 and path in the image naming, see https://ko.build/configuration/#naming-images This way we don't get the md5 in the repo name
* `--local` - local send the image to the docker daemon
