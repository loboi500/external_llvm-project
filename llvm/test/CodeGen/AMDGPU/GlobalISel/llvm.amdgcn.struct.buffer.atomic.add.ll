; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=fiji -stop-after=instruction-select -verify-machineinstrs -o - %s | FileCheck %s

; Natural mapping
define amdgpu_ps float @struct_buffer_atomic_add_i32__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset(i32 %val, <4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_atomic_add_i32__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; CHECK:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK:   [[COPY7:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY5]], %subreg.sub0, [[COPY6]], %subreg.sub1
  ; CHECK:   [[BUFFER_ATOMIC_ADD_BOTHEN_RTN:%[0-9]+]]:vgpr_32 = BUFFER_ATOMIC_ADD_BOTHEN_RTN [[COPY]], [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY7]], 0, 1, 0, implicit $exec :: (volatile dereferenceable load store 4 on custom "TargetCustom7", align 1, addrspace 4)
  ; CHECK:   $vgpr0 = COPY [[BUFFER_ATOMIC_ADD_BOTHEN_RTN]]
  ; CHECK:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %ret = call i32 @llvm.amdgcn.struct.buffer.atomic.add.i32(i32 %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  %cast = bitcast i32 %ret to float
  ret float %cast
}

define amdgpu_ps float @struct_buffer_atomic_add_i32_noret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset(i32 %val, <4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_atomic_add_i32_noret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; CHECK:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK:   [[COPY7:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY5]], %subreg.sub0, [[COPY6]], %subreg.sub1
  ; CHECK:   [[BUFFER_ATOMIC_ADD_BOTHEN_RTN:%[0-9]+]]:vgpr_32 = BUFFER_ATOMIC_ADD_BOTHEN_RTN [[COPY]], [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY7]], 0, 1, 0, implicit $exec :: (volatile dereferenceable load store 4 on custom "TargetCustom7", align 1, addrspace 4)
  ; CHECK:   $vgpr0 = COPY [[BUFFER_ATOMIC_ADD_BOTHEN_RTN]]
  ; CHECK:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %ret = call i32 @llvm.amdgcn.struct.buffer.atomic.add.i32(i32 %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  %cast = bitcast i32 %ret to float
  ret float %cast
}

define amdgpu_ps <2 x float> @struct_buffer_atomic_add_i64__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset(i64 %val, <4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_atomic_add_i64__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; CHECK:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; CHECK:   [[COPY8:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY3]], %subreg.sub1, [[COPY4]], %subreg.sub2, [[COPY5]], %subreg.sub3
  ; CHECK:   [[REG_SEQUENCE2:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY6]], %subreg.sub0, [[COPY7]], %subreg.sub1
  ; CHECK:   [[BUFFER_ATOMIC_ADD_X2_BOTHEN_RTN:%[0-9]+]]:vreg_64 = BUFFER_ATOMIC_ADD_X2_BOTHEN_RTN [[REG_SEQUENCE]], [[REG_SEQUENCE2]], [[REG_SEQUENCE1]], [[COPY8]], 0, 1, 0, implicit $exec :: (volatile dereferenceable load store 8 on custom "TargetCustom7", align 1, addrspace 4)
  ; CHECK:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_ATOMIC_ADD_X2_BOTHEN_RTN]].sub0
  ; CHECK:   [[COPY10:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_ATOMIC_ADD_X2_BOTHEN_RTN]].sub1
  ; CHECK:   $vgpr0 = COPY [[COPY9]]
  ; CHECK:   $vgpr1 = COPY [[COPY10]]
  ; CHECK:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1
  %ret = call i64 @llvm.amdgcn.struct.buffer.atomic.add.i64(i64 %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  %cast = bitcast i64 %ret to <2 x float>
  ret <2 x float> %cast
}

define amdgpu_ps void @struct_buffer_atomic_add_i64_noret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset(i64 %val, <4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_atomic_add_i64_noret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; CHECK:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; CHECK:   [[COPY8:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY3]], %subreg.sub1, [[COPY4]], %subreg.sub2, [[COPY5]], %subreg.sub3
  ; CHECK:   [[REG_SEQUENCE2:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY6]], %subreg.sub0, [[COPY7]], %subreg.sub1
  ; CHECK:   [[BUFFER_ATOMIC_ADD_X2_BOTHEN_RTN:%[0-9]+]]:vreg_64 = BUFFER_ATOMIC_ADD_X2_BOTHEN_RTN [[REG_SEQUENCE]], [[REG_SEQUENCE2]], [[REG_SEQUENCE1]], [[COPY8]], 0, 1, 0, implicit $exec :: (volatile dereferenceable load store 8 on custom "TargetCustom7", align 1, addrspace 4)
  ; CHECK:   S_ENDPGM 0
  %ret = call i64 @llvm.amdgcn.struct.buffer.atomic.add.i64(i64 %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

; All register operands need legalization
define amdgpu_ps float @struct_buffer_atomic_add_i32__sgpr_val__vgpr_rsrc__sgpr_voffset__vgpr_soffset(i32 inreg %val, <4 x i32> %rsrc, i32 inreg %vindex, i32 inreg %voffset, i32 %soffset) {
  ; CHECK-LABEL: name: struct_buffer_atomic_add_i32__sgpr_val__vgpr_rsrc__sgpr_voffset__vgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   successors: %bb.2(0x80000000)
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4
  ; CHECK:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; CHECK:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; CHECK:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[COPY]]
  ; CHECK:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY [[COPY5]]
  ; CHECK:   [[COPY10:%[0-9]+]]:vgpr_32 = COPY [[COPY6]]
  ; CHECK:   [[COPY11:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; CHECK:   [[COPY12:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; CHECK:   [[S_MOV_B64_term:%[0-9]+]]:sreg_64_xexec = S_MOV_B64_term $exec
  ; CHECK: bb.2:
  ; CHECK:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; CHECK:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY11]].sub0, implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY11]].sub1, implicit $exec
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1
  ; CHECK:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE1]], [[COPY11]], implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY12]].sub0, implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY12]].sub1, implicit $exec
  ; CHECK:   [[REG_SEQUENCE2:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_2]], %subreg.sub0, [[V_READFIRSTLANE_B32_3]], %subreg.sub1
  ; CHECK:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE2]], [[COPY12]], implicit $exec
  ; CHECK:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_1]], [[V_CMP_EQ_U64_e64_]], implicit-def $scc
  ; CHECK:   [[REG_SEQUENCE3:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; CHECK:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY7]], implicit $exec
  ; CHECK:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY7]], implicit $exec
  ; CHECK:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U32_e64_]], [[S_AND_B64_]], implicit-def $scc
  ; CHECK:   [[REG_SEQUENCE4:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY9]], %subreg.sub0, [[COPY10]], %subreg.sub1
  ; CHECK:   [[BUFFER_ATOMIC_ADD_BOTHEN_RTN:%[0-9]+]]:vgpr_32 = BUFFER_ATOMIC_ADD_BOTHEN_RTN [[COPY8]], [[REG_SEQUENCE4]], [[REG_SEQUENCE3]], [[V_READFIRSTLANE_B32_4]], 0, 1, 0, implicit $exec :: (volatile dereferenceable load store 4 on custom "TargetCustom7", align 1, addrspace 4)
  ; CHECK:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; CHECK:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; CHECK:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; CHECK: bb.3:
  ; CHECK:   successors: %bb.4(0x80000000)
  ; CHECK:   $exec = S_MOV_B64_term [[S_MOV_B64_term]]
  ; CHECK: bb.4:
  ; CHECK:   $vgpr0 = COPY [[BUFFER_ATOMIC_ADD_BOTHEN_RTN]]
  ; CHECK:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %ret = call i32 @llvm.amdgcn.struct.buffer.atomic.add.i32(i32 %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  %cast = bitcast i32 %ret to float
  ret float %cast
}

; All register operands need legalization
define amdgpu_ps void @struct_buffer_atomic_add_i32_noret__sgpr_val__vgpr_rsrc__sgpr_voffset__vgpr_soffset(i32 inreg %val, <4 x i32> %rsrc, i32 inreg %vindex, i32 inreg %voffset, i32 %soffset) {
  ; CHECK-LABEL: name: struct_buffer_atomic_add_i32_noret__sgpr_val__vgpr_rsrc__sgpr_voffset__vgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   successors: %bb.2(0x80000000)
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4
  ; CHECK:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; CHECK:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; CHECK:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[COPY]]
  ; CHECK:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY [[COPY5]]
  ; CHECK:   [[COPY10:%[0-9]+]]:vgpr_32 = COPY [[COPY6]]
  ; CHECK:   [[COPY11:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; CHECK:   [[COPY12:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; CHECK:   [[S_MOV_B64_term:%[0-9]+]]:sreg_64_xexec = S_MOV_B64_term $exec
  ; CHECK: bb.2:
  ; CHECK:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; CHECK:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY11]].sub0, implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY11]].sub1, implicit $exec
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1
  ; CHECK:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE1]], [[COPY11]], implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY12]].sub0, implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY12]].sub1, implicit $exec
  ; CHECK:   [[REG_SEQUENCE2:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_2]], %subreg.sub0, [[V_READFIRSTLANE_B32_3]], %subreg.sub1
  ; CHECK:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE2]], [[COPY12]], implicit $exec
  ; CHECK:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_1]], [[V_CMP_EQ_U64_e64_]], implicit-def $scc
  ; CHECK:   [[REG_SEQUENCE3:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; CHECK:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY7]], implicit $exec
  ; CHECK:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY7]], implicit $exec
  ; CHECK:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U32_e64_]], [[S_AND_B64_]], implicit-def $scc
  ; CHECK:   [[REG_SEQUENCE4:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY9]], %subreg.sub0, [[COPY10]], %subreg.sub1
  ; CHECK:   [[BUFFER_ATOMIC_ADD_BOTHEN_RTN:%[0-9]+]]:vgpr_32 = BUFFER_ATOMIC_ADD_BOTHEN_RTN [[COPY8]], [[REG_SEQUENCE4]], [[REG_SEQUENCE3]], [[V_READFIRSTLANE_B32_4]], 0, 1, 0, implicit $exec :: (volatile dereferenceable load store 4 on custom "TargetCustom7", align 1, addrspace 4)
  ; CHECK:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; CHECK:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; CHECK:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; CHECK: bb.3:
  ; CHECK:   successors: %bb.4(0x80000000)
  ; CHECK:   $exec = S_MOV_B64_term [[S_MOV_B64_term]]
  ; CHECK: bb.4:
  ; CHECK:   S_ENDPGM 0
  %ret = call i32 @llvm.amdgcn.struct.buffer.atomic.add.i32(i32 %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

; Natural mapping + slc
define amdgpu_ps float @struct_buffer_atomic_add_i32__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc(i32 %val, <4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_atomic_add_i32__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; CHECK:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK:   [[COPY7:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY5]], %subreg.sub0, [[COPY6]], %subreg.sub1
  ; CHECK:   [[BUFFER_ATOMIC_ADD_BOTHEN_RTN:%[0-9]+]]:vgpr_32 = BUFFER_ATOMIC_ADD_BOTHEN_RTN [[COPY]], [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY7]], 0, 1, 1, implicit $exec :: (volatile dereferenceable load store 4 on custom "TargetCustom7", align 1, addrspace 4)
  ; CHECK:   $vgpr0 = COPY [[BUFFER_ATOMIC_ADD_BOTHEN_RTN]]
  ; CHECK:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %ret = call i32 @llvm.amdgcn.struct.buffer.atomic.add.i32(i32 %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 2)
  %cast = bitcast i32 %ret to float
  ret float %cast
}

declare i32 @llvm.amdgcn.struct.buffer.atomic.add.i32(i32, <4 x i32>, i32, i32, i32, i32 immarg) #0
declare i64 @llvm.amdgcn.struct.buffer.atomic.add.i64(i64, <4 x i32>, i32, i32, i32, i32 immarg) #0

attributes #0 = { nounwind }
