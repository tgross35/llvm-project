// RUN: %clang_cc1 -triple x86_64-windows-gnu -emit-llvm -o - %s \
// RUN:    | FileCheck %s --check-prefix=GNU64
// __float128 is unsupported on MSVC

__float128 fp128_ret(void) { return 0; }
// GNU64: define dso_local fp128 @fp128_ret()

__float128 fp128_args(__float128 a, __float128 b) { return a * b; }
// GNU64: define dso_local fp128 @fp128_args(fp128 noundef %a, fp128 noundef %b)

void fp128_vararg(int a, ...) {
  // GNU64-LABEL: define dso_local void @fp128_vararg
  __builtin_va_list ap;
  __builtin_va_start(ap, a);
  __float128 i = __builtin_va_arg(ap, __float128);
  // movaps  xmm0, xmmword ptr [rax]
  // GNU64: load ptr, ptr
  // GNU64: load fp128, ptr
  __builtin_va_end(ap);
}
