// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple x86_64-unknown-linux-gnu -emit-llvm %s -o - | FileCheck %s

void *__attribute__((alloc_align(1))) alloc(int align);

// CHECK-LABEL: @t0(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[ALIGN_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store i32 [[ALIGN:%.*]], i32* [[ALIGN_ADDR]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[ALIGN_ADDR]], align 4
// CHECK-NEXT:    [[CALL:%.*]] = call i8* @alloc(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[TMP0]] to i64
// CHECK-NEXT:    call void @llvm.assume(i1 true) [ "align"(i8* [[CALL]], i64 [[TMP1]]) ]
// CHECK-NEXT:    ret void
//
void t0(int align) {
  alloc(align);
}
// CHECK-LABEL: @t1(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[ALIGN_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store i32 [[ALIGN:%.*]], i32* [[ALIGN_ADDR]], align 4
// CHECK-NEXT:    [[CALL:%.*]] = call i8* @alloc(i32 7)
// CHECK-NEXT:    call void @llvm.assume(i1 true) [ "align"(i8* [[CALL]], i64 7) ]
// CHECK-NEXT:    ret void
//
void t1(int align) {
  alloc(7);
}
// CHECK-LABEL: @t2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[ALIGN_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store i32 [[ALIGN:%.*]], i32* [[ALIGN_ADDR]], align 4
// CHECK-NEXT:    [[CALL:%.*]] = call align 8 i8* @alloc(i32 8)
// CHECK-NEXT:    ret void
//
void t2(int align) {
  alloc(8);
}
