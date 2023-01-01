// RUN: mlir-opt -test-spirv-module-combiner -split-input-file -verify-diagnostics %s | FileCheck %s

// Deduplicate 2 global variables with the same descriptor set and binding.

// CHECK:      module {
// CHECK-NEXT:   spv.module Logical GLSL450 {
// CHECK-NEXT:     spv.globalVariable @foo

// CHECK-NEXT:     spv.func @use_foo
// CHECK-NEXT:       spv.mlir.addressof @foo
// CHECK-NEXT:       spv.Load
// CHECK-NEXT:       spv.ReturnValue
// CHECK-NEXT:     }

// CHECK-NEXT:     spv.func @use_bar
// CHECK-NEXT:       spv.mlir.addressof @foo
// CHECK-NEXT:       spv.Load
// CHECK-NEXT:       spv.FAdd
// CHECK-NEXT:       spv.ReturnValue
// CHECK-NEXT:     }
// CHECK-NEXT:   }
// CHECK-NEXT: }

module {
spv.module Logical GLSL450 {
  spv.globalVariable @foo bind(1, 0) : !spv.ptr<f32, Input>

  spv.func @use_foo() -> f32 "None" {
    %0 = spv.mlir.addressof @foo : !spv.ptr<f32, Input>
    %1 = spv.Load "Input" %0 : f32
    spv.ReturnValue %1 : f32
  }
}

spv.module Logical GLSL450 {
  spv.globalVariable @bar bind(1, 0) : !spv.ptr<f32, Input>

  spv.func @use_bar() -> f32 "None" {
    %0 = spv.mlir.addressof @bar : !spv.ptr<f32, Input>
    %1 = spv.Load "Input" %0 : f32
    %2 = spv.FAdd %1, %1 : f32
    spv.ReturnValue %2 : f32
  }
}
}

// -----

// Deduplicate 2 global variables with the same descriptor set and binding but different types.

// CHECK:      module {
// CHECK-NEXT: spv.module Logical GLSL450 {
// CHECK-NEXT:   spv.globalVariable @foo bind(1, 0)

// CHECK-NEXT:   spv.globalVariable @bar bind(1, 0)

// CHECK-NEXT:   spv.func @use_bar
// CHECK-NEXT:     spv.mlir.addressof @bar
// CHECK-NEXT:     spv.Load
// CHECK-NEXT:     spv.ReturnValue
// CHECK-NEXT:   }
// CHECK-NEXT: }
// CHECK-NEXT: }

module {
spv.module Logical GLSL450 {
  spv.globalVariable @foo bind(1, 0) : !spv.ptr<i32, Input>
}

spv.module Logical GLSL450 {
  spv.globalVariable @bar bind(1, 0) : !spv.ptr<f32, Input>

  spv.func @use_bar() -> f32 "None" {
    %0 = spv.mlir.addressof @bar : !spv.ptr<f32, Input>
    %1 = spv.Load "Input" %0 : f32
    spv.ReturnValue %1 : f32
  }
}
}

// -----

// Deduplicate 2 global variables with the same built-in attribute.

// CHECK:      module {
// CHECK-NEXT:   spv.module Logical GLSL450 {
// CHECK-NEXT:     spv.globalVariable @foo built_in("GlobalInvocationId")
// CHECK-NEXT:     spv.func @use_bar
// CHECK-NEXT:       spv.mlir.addressof @foo
// CHECK-NEXT:       spv.Load
// CHECK-NEXT:       spv.ReturnValue
// CHECK-NEXT:     }
// CHECK-NEXT:   }
// CHECK-NEXT: }

module {
spv.module Logical GLSL450 {
  spv.globalVariable @foo built_in("GlobalInvocationId") : !spv.ptr<vector<3xi32>, Input>
}

spv.module Logical GLSL450 {
  spv.globalVariable @bar built_in("GlobalInvocationId") : !spv.ptr<vector<3xi32>, Input>

  spv.func @use_bar() -> vector<3xi32> "None" {
    %0 = spv.mlir.addressof @bar : !spv.ptr<vector<3xi32>, Input>
    %1 = spv.Load "Input" %0 : vector<3xi32>
    spv.ReturnValue %1 : vector<3xi32>
  }
}
}

// -----

// CHECK:      module {
// CHECK-NEXT:   spv.module Logical GLSL450 {
// CHECK-NEXT:     spv.specConstant @foo spec_id(5)

// CHECK-NEXT:     spv.func @use_foo()
// CHECK-NEXT:       %0 = spv.mlir.referenceof @foo
// CHECK-NEXT:       spv.ReturnValue
// CHECK-NEXT:     }

// CHECK-NEXT:     spv.func @use_bar()
// CHECK-NEXT:       %0 = spv.mlir.referenceof @foo
// CHECK-NEXT:       spv.FAdd
// CHECK-NEXT:       spv.ReturnValue
// CHECK-NEXT:     }
// CHECK-NEXT:   }
// CHECK-NEXT: }

module {
spv.module Logical GLSL450 {
  spv.specConstant @foo spec_id(5) = 1. : f32

  spv.func @use_foo() -> (f32) "None" {
    %0 = spv.mlir.referenceof @foo : f32
    spv.ReturnValue %0 : f32
  }
}

spv.module Logical GLSL450 {
  spv.specConstant @bar spec_id(5) = 1. : f32

  spv.func @use_bar() -> (f32) "None" {
    %0 = spv.mlir.referenceof @bar : f32
    %1 = spv.FAdd %0, %0 : f32
    spv.ReturnValue %1 : f32
  }
}
}

// -----

// CHECK:      module {
// CHECK-NEXT:   spv.module Logical GLSL450 {
// CHECK-NEXT:     spv.specConstant @bar spec_id(5)

// CHECK-NEXT:     spv.func @foo(%arg0: f32)
// CHECK-NEXT:       spv.ReturnValue
// CHECK-NEXT:     }

// CHECK-NEXT:     spv.func @foo_different_body(%arg0: f32)
// CHECK-NEXT:       spv.mlir.referenceof
// CHECK-NEXT:       spv.ReturnValue
// CHECK-NEXT:     }

// CHECK-NEXT:     spv.func @baz(%arg0: i32)
// CHECK-NEXT:       spv.ReturnValue
// CHECK-NEXT:     }

// CHECK-NEXT:     spv.func @baz_no_return(%arg0: i32)
// CHECK-NEXT:       spv.Return
// CHECK-NEXT:     }

// CHECK-NEXT:     spv.func @baz_no_return_different_control
// CHECK-NEXT:       spv.Return
// CHECK-NEXT:     }

// CHECK-NEXT:     spv.func @baz_no_return_another_control
// CHECK-NEXT:       spv.Return
// CHECK-NEXT:     }

// CHECK-NEXT:     spv.func @kernel
// CHECK-NEXT:       spv.Return
// CHECK-NEXT:     }

// CHECK-NEXT:     spv.func @kernel_different_attr
// CHECK-NEXT:       spv.Return
// CHECK-NEXT:     }
// CHECK-NEXT:   }
// CHECK-NEXT:   }

module {
spv.module Logical GLSL450 {
  spv.specConstant @bar spec_id(5) = 1. : f32

  spv.func @foo(%arg0: f32) -> (f32) "None" {
    spv.ReturnValue %arg0 : f32
  }

  spv.func @foo_duplicate(%arg0: f32) -> (f32) "None" {
    spv.ReturnValue %arg0 : f32
  }

  spv.func @foo_different_body(%arg0: f32) -> (f32) "None" {
    %0 = spv.mlir.referenceof @bar : f32
    spv.ReturnValue %arg0 : f32
  }

  spv.func @baz(%arg0: i32) -> (i32) "None" {
    spv.ReturnValue %arg0 : i32
  }

  spv.func @baz_no_return(%arg0: i32) "None" {
    spv.Return
  }

  spv.func @baz_no_return_duplicate(%arg0: i32) -> () "None" {
    spv.Return
  }

  spv.func @baz_no_return_different_control(%arg0: i32) -> () "Inline" {
    spv.Return
  }

  spv.func @baz_no_return_another_control(%arg0: i32) -> () "Inline|Pure" {
    spv.Return
  }

  spv.func @kernel(
    %arg0: f32,
    %arg1: !spv.ptr<!spv.struct<(!spv.array<12 x f32>)>, CrossWorkgroup>) "None"
  attributes {spv.entry_point_abi = {local_size = dense<[32, 1, 1]> : vector<3xi32>}} {
    spv.Return
  }

  spv.func @kernel_different_attr(
    %arg0: f32,
    %arg1: !spv.ptr<!spv.struct<(!spv.array<12 x f32>)>, CrossWorkgroup>) "None"
  attributes {spv.entry_point_abi = {local_size = dense<[64, 1, 1]> : vector<3xi32>}} {
    spv.Return
  }
}
}
