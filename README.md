----

[**HERE BE DRAGONS**](https://en.wikipedia.org/wiki/Here_be_dragons)

**ONLY meant for PROTOTYPING & EXPERIMENTAL purposes!**

**NOT FOR PRODUCTION, NOT FOR BETA, NOT FOR ALPHA, ONLY for DEVELOPMENT!**

**USE to EXPERIMENT, LEARN, and PROTOTYPE!**

[**HERE BE DRAGONS**](https://en.wikipedia.org/wiki/Here_be_dragons)

----

This code in this repository originated from a fork of the linux-sgx repository, and
using `git-filter-repo` only the file relevant to building IPP Crypto from source were
kept.

The goal of this repository is to better understand how to build IPP Crypto from source,
such that it can be used to build the linux-sgx SDK from source instead of using the
prebuilt binaries provided by Intel.

---

The ippcp library is built based on the Open Source project ipp-crypto:
   * https://github.com/intel/ipp-crypto/
   * branch: [ipp-crypto_2020_update3](https://github.com/intel/ipp-crypto/tree/ipp-crypto_2020_update3)

In order to build your own IPP crypto, please follow below steps:
1. Download the prebuilt mitigation tools package `as.ld.objdump.gold.{ver}.tar.gz` from [01.org](https://download.01.org/intel-sgx/latest/linux-latest/), extract the package and copy the tools to `/usr/local/bin`.
2. Read the ipp-crypto README to prepare your build environment.
3. Make sure ipp-crypto source code are prepared.
4. Build the target ippcp library with the prepared Makefile:

   a. Build the target ippcp library with All-Loads-Mitigation:

      ```shell
      $ make MITIGATION-CVE-2020-0551=LOAD
      ```

   b. Build the target ippcp library with Branch-Mitigation:

      ```shell
      $ make MITIGATION-CVE-2020-0551=CF
      ```

   c. Build the target ippcp library with No-Mitigation:

      ```shell
      $ make
      ```

The built-out static library `libippcp.a` and header files will be copied into the right
place. Remember to `make clean` before switching the build.

For IPP crypto reproducible build, please follow the instructions in
[reproducibility README.md](https://github.com/intel/linux-sgx/blob/master/linux/reproducibility/README.md)
to reproduce the prebuilt IPP crypto.
