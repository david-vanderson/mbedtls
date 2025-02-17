const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{ .name = "mbedtls", .target = target, .optimize = optimize });
    lib.addIncludePath(b.path("include"));
    lib.addIncludePath(b.path("library"));

    // not sure why, but mbedtls has runtime issues when it's not built as
    // release-small or with the -Os flag, definitely need to figure out what's
    // going on there
    lib.addCSourceFiles(.{ .files = srcs, .flags = &.{"-Os"} });
    lib.linkLibC();

    if (target.result.os.tag == .windows)
        lib.linkSystemLibrary("ws2_32");

    b.installArtifact(lib);
    lib.installHeadersDirectory(b.path("include"), "", .{});
}

const srcs = &.{
    "library/aes.c",
    "library/aesce.c",
    "library/aesni.c",
    "library/aria.c",
    "library/asn1parse.c",
    "library/asn1write.c",
    "library/base64.c",
    "library/bignum.c",
    "library/bignum_core.c",
    "library/bignum_mod.c",
    "library/bignum_mod_raw.c",
    "library/camellia.c",
    "library/ccm.c",
    "library/chacha20.c",
    "library/chachapoly.c",
    "library/cipher.c",
    "library/cipher_wrap.c",
    "library/cmac.c",
    "library/constant_time.c",
    "library/ctr_drbg.c",
    "library/debug.c",
    "library/des.c",
    "library/dhm.c",
    "library/ecdh.c",
    "library/ecdsa.c",
    "library/ecjpake.c",
    "library/ecp.c",
    "library/ecp_curves.c",
    "library/entropy.c",
    "library/entropy_poll.c",
    "library/error.c",
    "library/gcm.c",
    "library/hash_info.c",
    "library/hkdf.c",
    "library/hmac_drbg.c",
    "library/lmots.c",
    "library/lms.c",
    "library/md5.c",
    "library/md.c",
    "library/memory_buffer_alloc.c",
    "library/mps_reader.c",
    "library/mps_trace.c",
    "library/net_sockets.c",
    "library/nist_kw.c",
    "library/oid.c",
    "library/padlock.c",
    "library/pem.c",
    "library/pk.c",
    "library/pkcs12.c",
    "library/pkcs5.c",
    "library/pkcs7.c",
    "library/pkparse.c",
    "library/pk_wrap.c",
    "library/pkwrite.c",
    "library/platform.c",
    "library/platform_util.c",
    "library/poly1305.c",
    "library/psa_crypto_aead.c",
    "library/psa_crypto.c",
    "library/psa_crypto_cipher.c",
    "library/psa_crypto_client.c",
    "library/psa_crypto_driver_wrappers.c",
    "library/psa_crypto_ecp.c",
    "library/psa_crypto_hash.c",
    "library/psa_crypto_mac.c",
    "library/psa_crypto_pake.c",
    "library/psa_crypto_rsa.c",
    "library/psa_crypto_se.c",
    "library/psa_crypto_slot_management.c",
    "library/psa_crypto_storage.c",
    "library/psa_its_file.c",
    "library/psa_util.c",
    "library/ripemd160.c",
    "library/rsa_alt_helpers.c",
    "library/rsa.c",
    "library/sha1.c",
    "library/sha256.c",
    "library/sha512.c",
    "library/ssl_cache.c",
    "library/ssl_ciphersuites.c",
    "library/ssl_client.c",
    "library/ssl_cookie.c",
    "library/ssl_debug_helpers_generated.c",
    "library/ssl_msg.c",
    "library/ssl_ticket.c",
    "library/ssl_tls12_client.c",
    "library/ssl_tls12_server.c",
    "library/ssl_tls13_client.c",
    "library/ssl_tls13_generic.c",
    "library/ssl_tls13_keys.c",
    "library/ssl_tls13_server.c",
    "library/ssl_tls.c",
    "library/threading.c",
    "library/timing.c",
    "library/version.c",
    "library/version_features.c",
    "library/x509.c",
    "library/x509_create.c",
    "library/x509_crl.c",
    "library/x509_crt.c",
    "library/x509_csr.c",
    "library/x509write_crt.c",
    "library/x509write_csr.c",
};
