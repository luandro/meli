<h1 align="center">meli</h1>

<div align="center">
  <strong>Meli Android app built with p2panda</strong>
</div>

<br />

<div align="center">
  <h3>
    <a href="https://p2panda.org/about/contribute">
      Contribute
    </a>
    <span> | </span>
    <a href="https://p2panda.org">
      Website
    </a>
  </h3>
</div>

<br/>

## Requirements

> Listed versions are the ones we used successfully in our developer
> environments, other versions might work well too.

* [Rust](https://www.rust-lang.org/tools/install) `1.70.0`
* [Android SDK](https://developer.android.com/tools)
* [Android NDK](https://developer.android.com/ndk/)
* [Flutter SDK](https://docs.flutter.dev/get-started/install) `3.10.5` and Dart SDK `3.0.5`

## Development

This is a [Melos](https://melos.invertase.dev) mono-repository managing both
the Android application source-code and "external" Dart and Flutter libraries
providing all p2panda functionality via FFI bindings.

### Setup

```bash
# Install all Dart dependencies, including Melos
dart pub get

# Bootstrap your Melos environment
melos bs
```

### Code-Checks

```bash
# Check code style and correctness
melos analyze

# Format code according to guidelines
melos format
```

### FFI packages

To bring [`p2panda-rs`] and [`aquadoggo`] into a native Android environment
we're utilising [`flutter_rust_bridge`] which automatically generates Dart code
with FFI bindings from Rust.

The code resides in:

* [packages/p2panda/native]: Rust API used in the Android application
* [packages/p2panda]: p2panda Dart package
* [packages/p2panda_flutter]: p2panda Flutter package

```bash
# After changing the Rust code in `packages/p2panda/native` re-build the
# library. This automatically installs Android compilation targets and the
# cargo-ndk tool if missing.
melos build

# Bump the package versions after your changes. We're not (yet) releasing the
# Dart and Flutter packages publicly, but versioning is still required for the
# Gradle building pipeline to detect changes to the external, native libraries.
melos version
```

### Android App

It is recommended to develop or run the project with [Android Studio](https://developer.android.com/studio) or with the [`flutter-cli`] command line tool.

* [packages/app]: Android application built with Flutter

## License

GNU Affero General Public License v3.0 [`AGPL-3.0-or-later`](LICENSE)

## Supported by

<img src="https://raw.githubusercontent.com/p2panda/.github/main/assets/ngi-logo.png" width="auto" height="80px"><br />
<img src="https://raw.githubusercontent.com/p2panda/.github/main/assets/nlnet-logo.svg" width="auto" height="80px"><br />
<img src="https://raw.githubusercontent.com/p2panda/.github/main/assets/eu-flag-logo.png" width="auto" height="80px">

*This project has received funding from the European Union’s Horizon 2020
research and innovation programme within the framework of the NGI-POINTER
Project funded under grant agreement No 871528*

[`aquadoggo`]: https://github.com/p2panda/aquadoggo
[`flutter-cli`]: https://docs.flutter.dev/reference/flutter-cli
[`flutter_rust_bridge`]: https://github.com/fzyzcjy/flutter_rust_bridge
[`p2panda-rs`]: https://github.com/p2panda/p2panda
[`p2panda`]: https://p2panda.org
