// RUN: %clang_cc1 -triple x86_64-linux-android -emit-llvm -o - %s \
// RUN:    | FileCheck %s --check-prefix=A64
// RUN: %clang_cc1 -triple x86_64-linux-gnu -emit-llvm -o - %s \
// RUN:    | FileCheck %s --check-prefix=G64
// RUN: %clang_cc1 -triple powerpc64-linux-gnu -emit-llvm -o - %s \
// RUN:    | FileCheck %s --check-prefix=P64
// RUN: %clang_cc1 -triple i686-linux-android -emit-llvm -o - %s \
// RUN:    | FileCheck %s --check-prefix=A32
// RUN: %clang_cc1 -triple i686-linux-gnu -emit-llvm -o - %s \
// RUN:    | FileCheck %s --check-prefix=G32
// RUN: %clang_cc1 -triple powerpc-linux-gnu -emit-llvm -o - %s \
// RUN:    | FileCheck %s --check-prefix=P32
// RUN: %clang_cc1 -triple x86_64-nacl -emit-llvm -o - %s \
// RUN:    | FileCheck %s --check-prefix=N64

