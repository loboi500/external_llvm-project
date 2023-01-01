; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

;
; Tests for combining concat-able ops:
; or(zext(OP(x)), shl(zext(OP(y)),bw/2))
; -->
; OP(or(zext(x), shl(zext(y),bw/2)))
;

; BSWAP

; PR45715
define i64 @concat_bswap32_unary_split(i64 %a0) {
; CHECK-LABEL: @concat_bswap32_unary_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.bswap.i64(i64 [[A0:%.*]])
; CHECK-NEXT:    ret i64 [[TMP1]]
;
  %1 = lshr i64 %a0, 32
  %2 = trunc i64 %1 to i32
  %3 = trunc i64 %a0 to i32
  %4 = tail call i32 @llvm.bswap.i32(i32 %2)
  %5 = tail call i32 @llvm.bswap.i32(i32 %3)
  %6 = zext i32 %4 to i64
  %7 = zext i32 %5 to i64
  %8 = shl nuw i64 %7, 32
  %9 = or i64 %6, %8
  ret i64 %9
}

define <2 x i64> @concat_bswap32_unary_split_vector(<2 x i64> %a0) {
; CHECK-LABEL: @concat_bswap32_unary_split_vector(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> [[A0:%.*]])
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = lshr <2 x i64> %a0, <i64 32, i64 32>
  %2 = trunc <2 x i64> %1 to <2 x i32>
  %3 = trunc <2 x i64> %a0 to <2 x i32>
  %4 = tail call <2 x i32> @llvm.bswap.v2i32(<2 x i32> %2)
  %5 = tail call <2 x i32> @llvm.bswap.v2i32(<2 x i32> %3)
  %6 = zext <2 x i32> %4 to <2 x i64>
  %7 = zext <2 x i32> %5 to <2 x i64>
  %8 = shl nuw <2 x i64> %7, <i64 32, i64 32>
  %9 = or <2 x i64> %6, %8
  ret <2 x i64> %9
}

define i64 @concat_bswap32_unary_flip(i64 %a0) {
; CHECK-LABEL: @concat_bswap32_unary_flip(
; CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.fshl.i64(i64 [[A0:%.*]], i64 [[A0]], i64 32)
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.bswap.i64(i64 [[TMP1]])
; CHECK-NEXT:    ret i64 [[TMP2]]
;
  %1 = lshr i64 %a0, 32
  %2 = trunc i64 %1 to i32
  %3 = trunc i64 %a0 to i32
  %4 = tail call i32 @llvm.bswap.i32(i32 %2)
  %5 = tail call i32 @llvm.bswap.i32(i32 %3)
  %6 = zext i32 %4 to i64
  %7 = zext i32 %5 to i64
  %8 = shl nuw i64 %6, 32
  %9 = or i64 %7, %8
  ret i64 %9
}

define <2 x i64> @concat_bswap32_unary_flip_vector(<2 x i64> %a0) {
; CHECK-LABEL: @concat_bswap32_unary_flip_vector(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i64> @llvm.fshl.v2i64(<2 x i64> [[A0:%.*]], <2 x i64> [[A0]], <2 x i64> <i64 32, i64 32>)
; CHECK-NEXT:    [[TMP2:%.*]] = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> [[TMP1]])
; CHECK-NEXT:    ret <2 x i64> [[TMP2]]
;
  %1 = lshr <2 x i64> %a0, <i64 32, i64 32>
  %2 = trunc <2 x i64> %1 to <2 x i32>
  %3 = trunc <2 x i64> %a0 to <2 x i32>
  %4 = tail call <2 x i32> @llvm.bswap.v2i32(<2 x i32> %2)
  %5 = tail call <2 x i32> @llvm.bswap.v2i32(<2 x i32> %3)
  %6 = zext <2 x i32> %4 to <2 x i64>
  %7 = zext <2 x i32> %5 to <2 x i64>
  %8 = shl nuw <2 x i64> %6, <i64 32, i64 32>
  %9 = or <2 x i64> %7, %8
  ret <2 x i64> %9
}

define i64 @concat_bswap32_binary(i32 %a0, i32 %a1) {
; CHECK-LABEL: @concat_bswap32_binary(
; CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[A1:%.*]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[A0:%.*]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = shl nuw i64 [[TMP2]], 32
; CHECK-NEXT:    [[TMP4:%.*]] = or i64 [[TMP3]], [[TMP1]]
; CHECK-NEXT:    [[TMP5:%.*]] = call i64 @llvm.bswap.i64(i64 [[TMP4]])
; CHECK-NEXT:    ret i64 [[TMP5]]
;
  %1 = tail call i32 @llvm.bswap.i32(i32 %a0)
  %2 = tail call i32 @llvm.bswap.i32(i32 %a1)
  %3 = zext i32 %1 to i64
  %4 = zext i32 %2 to i64
  %5 = shl nuw i64 %4, 32
  %6 = or i64 %3, %5
  ret i64 %6
}

define <2 x i64> @concat_bswap32_binary_vector(<2 x i32> %a0, <2 x i32> %a1) {
; CHECK-LABEL: @concat_bswap32_binary_vector(
; CHECK-NEXT:    [[TMP1:%.*]] = zext <2 x i32> [[A1:%.*]] to <2 x i64>
; CHECK-NEXT:    [[TMP2:%.*]] = zext <2 x i32> [[A0:%.*]] to <2 x i64>
; CHECK-NEXT:    [[TMP3:%.*]] = shl nuw <2 x i64> [[TMP2]], <i64 32, i64 32>
; CHECK-NEXT:    [[TMP4:%.*]] = or <2 x i64> [[TMP3]], [[TMP1]]
; CHECK-NEXT:    [[TMP5:%.*]] = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> [[TMP4]])
; CHECK-NEXT:    ret <2 x i64> [[TMP5]]
;
  %1 = tail call <2 x i32> @llvm.bswap.v2i32(<2 x i32> %a0)
  %2 = tail call <2 x i32> @llvm.bswap.v2i32(<2 x i32> %a1)
  %3 = zext <2 x i32> %1 to <2 x i64>
  %4 = zext <2 x i32> %2 to <2 x i64>
  %5 = shl nuw <2 x i64> %4, <i64 32, i64 32>
  %6 = or <2 x i64> %3, %5
  ret <2 x i64> %6
}

declare i32 @llvm.bswap.i32(i32)
declare <2 x i32> @llvm.bswap.v2i32(<2 x i32>)

; BITREVERSE

define i64 @concat_bitreverse32_unary_split(i64 %a0) {
; CHECK-LABEL: @concat_bitreverse32_unary_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.bitreverse.i64(i64 [[A0:%.*]])
; CHECK-NEXT:    ret i64 [[TMP1]]
;
  %1 = lshr i64 %a0, 32
  %2 = trunc i64 %1 to i32
  %3 = trunc i64 %a0 to i32
  %4 = tail call i32 @llvm.bitreverse.i32(i32 %2)
  %5 = tail call i32 @llvm.bitreverse.i32(i32 %3)
  %6 = zext i32 %4 to i64
  %7 = zext i32 %5 to i64
  %8 = shl nuw i64 %7, 32
  %9 = or i64 %6, %8
  ret i64 %9
}

define <2 x i64> @concat_bitreverse32_unary_split_vector(<2 x i64> %a0) {
; CHECK-LABEL: @concat_bitreverse32_unary_split_vector(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i64> @llvm.bitreverse.v2i64(<2 x i64> [[A0:%.*]])
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = lshr <2 x i64> %a0, <i64 32, i64 32>
  %2 = trunc <2 x i64> %1 to <2 x i32>
  %3 = trunc <2 x i64> %a0 to <2 x i32>
  %4 = tail call <2 x i32> @llvm.bitreverse.v2i32(<2 x i32> %2)
  %5 = tail call <2 x i32> @llvm.bitreverse.v2i32(<2 x i32> %3)
  %6 = zext <2 x i32> %4 to <2 x i64>
  %7 = zext <2 x i32> %5 to <2 x i64>
  %8 = shl nuw <2 x i64> %7, <i64 32, i64 32>
  %9 = or <2 x i64> %6, %8
  ret <2 x i64> %9
}

define i64 @concat_bitreverse32_unary_flip(i64 %a0) {
; CHECK-LABEL: @concat_bitreverse32_unary_flip(
; CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.fshl.i64(i64 [[A0:%.*]], i64 [[A0]], i64 32)
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.bitreverse.i64(i64 [[TMP1]])
; CHECK-NEXT:    ret i64 [[TMP2]]
;
  %1 = lshr i64 %a0, 32
  %2 = trunc i64 %1 to i32
  %3 = trunc i64 %a0 to i32
  %4 = tail call i32 @llvm.bitreverse.i32(i32 %2)
  %5 = tail call i32 @llvm.bitreverse.i32(i32 %3)
  %6 = zext i32 %4 to i64
  %7 = zext i32 %5 to i64
  %8 = shl nuw i64 %6, 32
  %9 = or i64 %7, %8
  ret i64 %9
}

define <2 x i64> @concat_bitreverse32_unary_flip_vector(<2 x i64> %a0) {
; CHECK-LABEL: @concat_bitreverse32_unary_flip_vector(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i64> @llvm.fshl.v2i64(<2 x i64> [[A0:%.*]], <2 x i64> [[A0]], <2 x i64> <i64 32, i64 32>)
; CHECK-NEXT:    [[TMP2:%.*]] = call <2 x i64> @llvm.bitreverse.v2i64(<2 x i64> [[TMP1]])
; CHECK-NEXT:    ret <2 x i64> [[TMP2]]
;
  %1 = lshr <2 x i64> %a0, <i64 32, i64 32>
  %2 = trunc <2 x i64> %1 to <2 x i32>
  %3 = trunc <2 x i64> %a0 to <2 x i32>
  %4 = tail call <2 x i32> @llvm.bitreverse.v2i32(<2 x i32> %2)
  %5 = tail call <2 x i32> @llvm.bitreverse.v2i32(<2 x i32> %3)
  %6 = zext <2 x i32> %4 to <2 x i64>
  %7 = zext <2 x i32> %5 to <2 x i64>
  %8 = shl nuw <2 x i64> %6, <i64 32, i64 32>
  %9 = or <2 x i64> %7, %8
  ret <2 x i64> %9
}

define i64 @concat_bitreverse32_binary(i32 %a0, i32 %a1) {
; CHECK-LABEL: @concat_bitreverse32_binary(
; CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[A1:%.*]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[A0:%.*]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = shl nuw i64 [[TMP2]], 32
; CHECK-NEXT:    [[TMP4:%.*]] = or i64 [[TMP3]], [[TMP1]]
; CHECK-NEXT:    [[TMP5:%.*]] = call i64 @llvm.bitreverse.i64(i64 [[TMP4]])
; CHECK-NEXT:    ret i64 [[TMP5]]
;
  %1 = tail call i32 @llvm.bitreverse.i32(i32 %a0)
  %2 = tail call i32 @llvm.bitreverse.i32(i32 %a1)
  %3 = zext i32 %1 to i64
  %4 = zext i32 %2 to i64
  %5 = shl nuw i64 %4, 32
  %6 = or i64 %3, %5
  ret i64 %6
}

define <2 x i64> @concat_bitreverse32_binary_vector(<2 x i32> %a0, <2 x i32> %a1) {
; CHECK-LABEL: @concat_bitreverse32_binary_vector(
; CHECK-NEXT:    [[TMP1:%.*]] = zext <2 x i32> [[A1:%.*]] to <2 x i64>
; CHECK-NEXT:    [[TMP2:%.*]] = zext <2 x i32> [[A0:%.*]] to <2 x i64>
; CHECK-NEXT:    [[TMP3:%.*]] = shl nuw <2 x i64> [[TMP2]], <i64 32, i64 32>
; CHECK-NEXT:    [[TMP4:%.*]] = or <2 x i64> [[TMP3]], [[TMP1]]
; CHECK-NEXT:    [[TMP5:%.*]] = call <2 x i64> @llvm.bitreverse.v2i64(<2 x i64> [[TMP4]])
; CHECK-NEXT:    ret <2 x i64> [[TMP5]]
;
  %1 = tail call <2 x i32> @llvm.bitreverse.v2i32(<2 x i32> %a0)
  %2 = tail call <2 x i32> @llvm.bitreverse.v2i32(<2 x i32> %a1)
  %3 = zext <2 x i32> %1 to <2 x i64>
  %4 = zext <2 x i32> %2 to <2 x i64>
  %5 = shl nuw <2 x i64> %4, <i64 32, i64 32>
  %6 = or <2 x i64> %3, %5
  ret <2 x i64> %6
}

declare i32 @llvm.bitreverse.i32(i32)
declare <2 x i32> @llvm.bitreverse.v2i32(<2 x i32>)
