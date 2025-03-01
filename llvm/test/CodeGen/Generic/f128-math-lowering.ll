; 
; RUN: llc < %s -mtriple=aarch64-unknown-none -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-F128
; RUN: llc < %s -mtriple=i686-unknown -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-F128
; RUN: llc < %s -mtriple=powerpc-unknown -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-F128
; RUN: llc < %s -mtriple=powerpc64-unknown -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-F128
; RUN: llc < %s -mtriple=riscv32 -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-F128
; RUN: llc < %s -mtriple=s390x-unknown -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-S390X
; RUN: llc < %s -mtriple=x86_64-unknown -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-F128
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-F128
; RUN: llc < %s -mtriple=x86_64-unknown-linux-musl -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-F128
; RUN: sed 's/; flag://' %s | llc -mtriple=aarch64-unknown-none -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-USELD
; RUN: sed 's/; flag://' %s | llc -mtriple=i686-unknown -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-USELD
; RUN: sed 's/; flag://' %s | llc -mtriple=powerpc-unknown -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-USELD
; RUN: sed 's/; flag://' %s | llc -mtriple=powerpc64-unknown -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-USELD
; RUN: sed 's/; flag://' %s | llc -mtriple=riscv32 -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-USELD
; RUN: sed 's/; flag://' %s | llc -mtriple=s390x-unknown -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-S390X
; RUN: sed 's/; flag://' %s | llc -mtriple=x86_64-unknown -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-USELD
; RUN: sed 's/; flag://' %s | llc -mtriple=x86_64-unknown-linux-gnu -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-USELD
; RUN: sed 's/; flag://' %s | llc -mtriple=x86_64-unknown-linux-musl -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-USELD
;
; REQUIRES: aarch64-registered-target
; REQUIRES: powerpc-registered-target
; REQUIRES: riscv-registered-target
; REQUIRES: systemz-registered-target
; REQUIRES: x86-registered-target
;
; Verify that fp128 intrinsics only lower to `long double` calls (e.g. `sinl`)
; on platforms where `f128` and `long double` have the same layout, and
; otherwise lower to `f128` versions (e.g. `sinf128`).
;
; Targets include:
; * x86, x64 (80-bit long double)
; * aarch64 (long double == f128)
; * riscv32 (long double == f64)
; * s390x (long double == f128, hardware support)
; * A couple assorted environments for x86


; flag: !0 = !{ i32 1, !"Fp128 Libcall Format", i32 1 }
; flag: !llvm.module.flags = !{ !0 }

define fp128 @test_acosf128(fp128 %a) {
; CHECK-LABEL:      test_acosf128:
; CHECK-F128:       acosf128
; CHECK-USELD:      acosl
; CHECK-S390X:      acosf128
start:
  %0 = tail call fp128 @llvm.acos.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_asinf128(fp128 %a) {
; CHECK-LABEL:      test_asinf128:
; CHECK-F128:       asinf128
; CHECK-USELD:      asinl
; CHECK-S390X:      asinf128
start:
  %0 = tail call fp128 @llvm.asin.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_atanf128(fp128 %a) {
; CHECK-LABEL:      test_atanf128:
; CHECK-F128:       atanf128
; CHECK-USELD:      atanl
; CHECK-S390X:      atanf128
start:
  %0 = tail call fp128 @llvm.atan.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_ceilf128(fp128 %a) {
; CHECK-LABEL:      test_ceilf128:
; CHECK-F128:       ceilf128
; CHECK-USELD:      ceill
; CHECK-S390X:      ceilf128
start:
  %0 = tail call fp128 @llvm.ceil.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_copysignf128(fp128 %a, fp128 %b) {
; copysign should always get lowered to assembly. Regex is needed so as not to
; match the label.
; CHECK-LABEL:      test_copysignf128:
; CHECK-NOT:        {{(^|[[:space:]])fabsf128($|[[:space:]])}}
; CHECK-NOT:        {{(^|[[:space:]])fabsl($|[[:space:]])}}
start:
  %0 = tail call fp128 @llvm.copysign.f128(fp128 %a, fp128 %b)
  ret fp128 %0
}

define fp128 @test_cosf128(fp128 %a) {
; CHECK-LABEL:      test_cosf128:
; CHECK-F128:       cosf128
; CHECK-USELD:      cosl
; CHECK-S390X:      cosf128
start:
  %0 = tail call fp128 @llvm.cos.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_exp10f128(fp128 %a) {
; CHECK-LABEL:      test_exp10f128:
; CHECK-F128:       exp10f128
; CHECK-USELD:      exp10l
; CHECK-S390X:      exp10f128
start:
  %0 = tail call fp128 @llvm.exp10.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_exp2f128(fp128 %a) {
; CHECK-LABEL:      test_exp2f128:
; CHECK-F128:       exp2f128
; CHECK-USELD:      exp2l
; CHECK-S390X:      exp2f128
start:
  %0 = tail call fp128 @llvm.exp2.f128(fp128 %a)
  ret fp128 %0
}


define fp128 @test_expf128(fp128 %a) {
; CHECK-LABEL:      test_expf128:
; CHECK-F128:       expf128
; CHECK-USELD:      expl
; CHECK-S390X:      expf128
start:
  %0 = tail call fp128 @llvm.exp.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_fabsf128(fp128 %a) {
; fabs should always get lowered to assembly. Regex is needed so as not to
; match the label.
; CHECK-LABEL:      test_fabsf128:
; CHECK-NOT:        {{(^|[[:space:]])fabsf128($|[[:space:]])}}
; CHECK-NOT:        {{(^|[[:space:]])fabsl($|[[:space:]])}}
start:
  %0 = tail call fp128 @llvm.fabs.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_floorf128(fp128 %a) {
; CHECK-LABEL:      test_floorf128:
; CHECK-F128:       floorf128
; CHECK-USELD:      floorl
; CHECK-S390X:      floorf128
start:
  %0 = tail call fp128 @llvm.floor.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_fmaf128(fp128 %a, fp128 %b, fp128 %c) {
; CHECK-LABEL:      test_fmaf128:
; CHECK-F128:       fmaf128
; CHECK-USELD:      fmal
; CHECK-S390X:      fmaf128
start:
  %0 = tail call fp128 @llvm.fma.f128(fp128 %a, fp128 %b, fp128 %c)
  ret fp128 %0
}

define { fp128, i32 } @test_frexpf128(fp128 %a) {
; CHECK-LABEL:      test_frexpf128:
; CHECK-F128:       frexpf128
; CHECK-USELD:      frexpl
; CHECK-S390X:      frexpf128
start:
  %0 = tail call { fp128, i32 } @llvm.frexp.f128(fp128 %a)
  ret { fp128, i32 } %0
}

define fp128 @test_ldexpf128(fp128 %a, i32 %b) {
; CHECK-LABEL:      test_ldexpf128:
; CHECK-F128:       ldexpf128
; CHECK-USELD:      ldexpl
; CHECK-S390X:      ldexpf128
start:
  %0 = tail call fp128 @llvm.ldexp.f128(fp128 %a, i32 %b)
  ret fp128 %0
}

define i64 @test_llrintf128(fp128 %a) {
; CHECK-LABEL:      test_llrintf128:
; CHECK-F128:       llrintf128
; CHECK-USELD:      llrintl
; CHECK-S390X:      llrintf128
start:
  %0 = tail call i64 @llvm.llrint.f128(fp128 %a)
  ret i64 %0
}

define i64 @test_llroundf128(fp128 %a) {
; CHECK-LABEL:      test_llroundf128:
; CHECK-F128:       llroundf128
; CHECK-USELD:      llroundl
; CHECK-S390X:      llroundf128
start:
  %0 = tail call i64 @llvm.llround.i64.f128(fp128 %a)
  ret i64 %0
}

define fp128 @test_log10f128(fp128 %a) {
; CHECK-LABEL:      test_log10f128:
; CHECK-F128:       log10f128
; CHECK-USELD:      log10l
; CHECK-S390X:      log10f128
start:
  %0 = tail call fp128 @llvm.log10.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_log2f128(fp128 %a) {
; CHECK-LABEL:      test_log2f128:
; CHECK-F128:       log2f128
; CHECK-USELD:      log2l
; CHECK-S390X:      log2f128
start:
  %0 = tail call fp128 @llvm.log2.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_logf128(fp128 %a) {
; CHECK-LABEL:      test_logf128:
; CHECK-F128:       logf128
; CHECK-USELD:      logl
; CHECK-S390X:      logf128
start:
  %0 = tail call fp128 @llvm.log.f128(fp128 %a)
  ret fp128 %0
}

define i64 @test_lrintf128(fp128 %a) {
; CHECK-LABEL:      test_lrintf128:
; CHECK-F128:       lrintf128
; CHECK-USELD:      lrintl
; CHECK-S390X:      lrintf128
start:
  %0 = tail call i64 @llvm.lrint.f128(fp128 %a)
  ret i64 %0
}

define i64 @test_lroundf128(fp128 %a) {
; CHECK-LABEL:      test_lroundf128:
; CHECK-F128:       lroundf128
; CHECK-USELD:      lroundl
; CHECK-S390X:      lroundf128
start:
  %0 = tail call i64 @llvm.lround.i64.f128(fp128 %a)
  ret i64 %0
}

define fp128 @test_nearbyintf128(fp128 %a) {
; CHECK-LABEL:      test_nearbyintf128:
; CHECK-F128:       nearbyintf128
; CHECK-USELD:      nearbyintl
; CHECK-S390X:      nearbyintf128
start:
  %0 = tail call fp128 @llvm.nearbyint.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_powf128(fp128 %a, fp128 %b) {
; CHECK-LABEL:      test_powf128:
; CHECK-F128:       powf128
; CHECK-USELD:      powl
; CHECK-S390X:      powf128
start:
  %0 = tail call fp128 @llvm.pow.f128(fp128 %a, fp128 %b)
  ret fp128 %0
}

define fp128 @test_rintf128(fp128 %a) {
; CHECK-LABEL:      test_rintf128:
; CHECK-F128:       rintf128
; CHECK-USELD:      rintl
; CHECK-S390X:      fixbr {{%.*}}, 0, {{%.*}}
start:
  %0 = tail call fp128 @llvm.rint.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_roundevenf128(fp128 %a) {
; CHECK-LABEL:      test_roundevenf128:
; CHECK-F128:       roundevenf128
; CHECK-USELD:      roundevenl
; CHECK-S390X:      roundevenf128
start:
  %0 = tail call fp128 @llvm.roundeven.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_roundf128(fp128 %a) {
; CHECK-LABEL:      test_roundf128:
; CHECK-F128:       roundf128
; CHECK-USELD:      roundl
; CHECK-S390X:      roundf128
start:
  %0 = tail call fp128 @llvm.round.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_sinf128(fp128 %a) {
; CHECK-LABEL:      test_sinf128:
; CHECK-F128:       sinf128
; CHECK-USELD:      sinl
; CHECK-S390X:      sinf128
start:
  %0 = tail call fp128 @llvm.sin.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_sqrtf128(fp128 %a) {
; CHECK-LABEL:      test_sqrtf128:
; CHECK-F128:       sqrtf128
; CHECK-USELD:      sqrtl
; CHECK-S390X:      sqxbr {{%.*}}, {{%.*}}
start:
  %0 = tail call fp128 @llvm.sqrt.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_tanf128(fp128 %a) {
; CHECK-LABEL:      test_tanf128:
; CHECK-F128:       tanf128
; CHECK-USELD:      tanl
; CHECK-S390X:      tanf128
start:
  %0 = tail call fp128 @llvm.tan.f128(fp128 %a)
  ret fp128 %0
}

define fp128 @test_truncf128(fp128 %a) {
; CHECK-LABEL:      test_truncf128:
; CHECK-F128:       truncf128
; CHECK-USELD:      truncl
; CHECK-S390X:      truncf128
start:
  %0 = tail call fp128 @llvm.trunc.f128(fp128 %a)
  ret fp128 %0
}
