# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -timeline -timeline-max-iterations=5 < %s | FileCheck %s

sete %r9b
movzbl %al, %eax
shll $2, %eax
imull %ecx, %eax
cmpl $1025, %eax

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      500
# CHECK-NEXT: Total Cycles:      504
# CHECK-NEXT: Total uOps:        500

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    0.99
# CHECK-NEXT: IPC:               0.99
# CHECK-NEXT: Block RThroughput: 1.3

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.50                        sete	%r9b
# CHECK-NEXT:  1      1     0.33                        movzbl	%al, %eax
# CHECK-NEXT:  1      1     0.50                        shll	$2, %eax
# CHECK-NEXT:  1      3     1.00                        imull	%ecx, %eax
# CHECK-NEXT:  1      1     0.33                        cmpl	$1025, %eax

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -     1.66   1.67    -     1.67    -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -     0.66    -      -     0.34    -      -     sete	%r9b
# CHECK-NEXT:  -      -     0.33   0.34    -     0.33    -      -     movzbl	%al, %eax
# CHECK-NEXT:  -      -     0.34    -      -     0.66    -      -     shll	$2, %eax
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -     imull	%ecx, %eax
# CHECK-NEXT:  -      -     0.33   0.33    -     0.34    -      -     cmpl	$1025, %eax

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789
# CHECK-NEXT: Index     0123456789          012345678

# CHECK:      [0,0]     DeER .    .    .    .    .  .   sete	%r9b
# CHECK-NEXT: [0,1]     DeER .    .    .    .    .  .   movzbl	%al, %eax
# CHECK-NEXT: [0,2]     D=eER.    .    .    .    .  .   shll	$2, %eax
# CHECK-NEXT: [0,3]     D==eeeER  .    .    .    .  .   imull	%ecx, %eax
# CHECK-NEXT: [0,4]     .D====eER .    .    .    .  .   cmpl	$1025, %eax
# CHECK-NEXT: [1,0]     .D=====eER.    .    .    .  .   sete	%r9b
# CHECK-NEXT: [1,1]     .D====eE-R.    .    .    .  .   movzbl	%al, %eax
# CHECK-NEXT: [1,2]     .D=====eER.    .    .    .  .   shll	$2, %eax
# CHECK-NEXT: [1,3]     . D=====eeeER  .    .    .  .   imull	%ecx, %eax
# CHECK-NEXT: [1,4]     . D========eER .    .    .  .   cmpl	$1025, %eax
# CHECK-NEXT: [2,0]     . D=========eER.    .    .  .   sete	%r9b
# CHECK-NEXT: [2,1]     . D========eE-R.    .    .  .   movzbl	%al, %eax
# CHECK-NEXT: [2,2]     .  D========eER.    .    .  .   shll	$2, %eax
# CHECK-NEXT: [2,3]     .  D=========eeeER  .    .  .   imull	%ecx, %eax
# CHECK-NEXT: [2,4]     .  D============eER .    .  .   cmpl	$1025, %eax
# CHECK-NEXT: [3,0]     .  D=============eER.    .  .   sete	%r9b
# CHECK-NEXT: [3,1]     .   D===========eE-R.    .  .   movzbl	%al, %eax
# CHECK-NEXT: [3,2]     .   D============eER.    .  .   shll	$2, %eax
# CHECK-NEXT: [3,3]     .   D=============eeeER  .  .   imull	%ecx, %eax
# CHECK-NEXT: [3,4]     .   D================eER .  .   cmpl	$1025, %eax
# CHECK-NEXT: [4,0]     .    D================eER.  .   sete	%r9b
# CHECK-NEXT: [4,1]     .    D===============eE-R.  .   movzbl	%al, %eax
# CHECK-NEXT: [4,2]     .    D================eER.  .   shll	$2, %eax
# CHECK-NEXT: [4,3]     .    D=================eeeER.   imull	%ecx, %eax
# CHECK-NEXT: [4,4]     .    .D===================eER   cmpl	$1025, %eax

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     5     9.6    0.2    0.0       sete	%r9b
# CHECK-NEXT: 1.     5     8.6    0.2    0.8       movzbl	%al, %eax
# CHECK-NEXT: 2.     5     9.4    0.0    0.0       shll	$2, %eax
# CHECK-NEXT: 3.     5     10.2   0.0    0.0       imull	%ecx, %eax
# CHECK-NEXT: 4.     5     12.8   0.0    0.0       cmpl	$1025, %eax
# CHECK-NEXT:        5     10.1   0.1    0.2       <total>
