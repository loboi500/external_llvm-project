//===-- SPIRVCompositeOps.td - MLIR SPIR-V Composite Ops ---*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains composite ops for SPIR-V dialect. It corresponds
// to "3.32.12. Composite Instructions" of the SPIR-V spec.
//
//===----------------------------------------------------------------------===//

#ifndef SPIRV_COMPOSITE_OPS
#define SPIRV_COMPOSITE_OPS

include "mlir/Dialect/SPIRV/SPIRVBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

// -----

def SPV_CompositeConstructOp : SPV_Op<"CompositeConstruct", [NoSideEffect]> {
  let summary = [{
    Construct a new composite object from a set of constituent objects that
    will fully form it.
  }];

  let description = [{
    Result Type must be a composite type, whose top-level
    members/elements/components/columns have the same type as the types of
    the operands, with one exception. The exception is that for constructing
    a vector, the operands may also be vectors with the same component type
    as the Result Type component type. When constructing a vector, the total
    number of components in all the operands must equal the number of
    components in Result Type.

    Constituents will become members of a structure, or elements of an
    array, or components of a vector, or columns of a matrix. There must be
    exactly one Constituent for each top-level
    member/element/component/column of the result, with one exception. The
    exception is that for constructing a vector, a contiguous subset of the
    scalars consumed can be represented by a vector operand instead. The
    Constituents must appear in the order needed by the definition of the
    type of the result. When constructing a vector, there must be at least
    two Constituent operands.

    <!-- End of AutoGen section -->

    ```
    composite-construct-op ::= ssa-id `=` `spv.CompositeConstruct`
                               (ssa-use (`,` ssa-use)* )? `:` composite-type
    ```

    #### Example:

    ```mlir
    %0 = spv.CompositeConstruct %1, %2, %3 : vector<3xf32>
    ```
  }];

  let arguments = (ins
    Variadic<SPV_Type>:$constituents
  );

  let results = (outs
    SPV_Composite:$result
  );
}

// -----

def SPV_CompositeExtractOp : SPV_Op<"CompositeExtract", [NoSideEffect]> {
  let summary = "Extract a part of a composite object.";

  let description = [{
    Result Type must be the type of object selected by the last provided
    index.  The instruction result is the extracted object.

    Composite is the composite to extract from.

    Indexes walk the type hierarchy, potentially down to component
    granularity, to select the part to extract. All indexes must be in
    bounds.  All composite constituents use zero-based numbering, as
    described by their OpType??? instruction.

    <!-- End of AutoGen section -->

    ```
    composite-extract-op ::= ssa-id `=` `spv.CompositeExtract` ssa-use
                             `[` integer-literal (',' integer-literal)* `]`
                             `:` composite-type
    ```

    #### Example:

    ```mlir
    %0 = spv.Variable : !spv.ptr<!spv.array<4x!spv.array<4xf32>>, Function>
    %1 = spv.Load "Function" %0 ["Volatile"] : !spv.array<4x!spv.array<4xf32>>
    %2 = spv.CompositeExtract %1[1 : i32] : !spv.array<4x!spv.array<4xf32>>
    ```

  }];

  let arguments = (ins
    SPV_Composite:$composite,
    I32ArrayAttr:$indices
  );

  let results = (outs
    SPV_Type:$component
  );

  let builders = [
    OpBuilderDAG<(ins "Value":$composite, "ArrayRef<int32_t>":$indices)>
  ];

  let hasFolder = 1;
}

// -----

def SPV_CompositeInsertOp : SPV_Op<"CompositeInsert", [NoSideEffect]> {
  let summary = [{
    Make a copy of a composite object, while modifying one part of it.
  }];

  let description = [{
    Result Type must be the same type as Composite.

    Object is the object to use as the modified part.

    Composite is the composite to copy all but the modified part from.

    Indexes walk the type hierarchy of Composite to the desired depth,
    potentially down to component granularity, to select the part to modify.
    All indexes must be in bounds. All composite constituents use zero-based
    numbering, as described by their OpType??? instruction. The type of the
    part selected to modify must match the type of Object.

    <!-- End of AutoGen section -->

    ```
    composite-insert-op ::= ssa-id `=` `spv.CompositeInsert` ssa-use, ssa-use
                            `[` integer-literal (',' integer-literal)* `]`
                            `:` object-type `into` composite-type
    ```

    #### Example:

    ```mlir
    %0 = spv.CompositeInsert %object, %composite[1 : i32] : f32 into !spv.array<4xf32>
    ```
  }];

  let arguments = (ins
    SPV_Type:$object,
    SPV_Composite:$composite,
    I32ArrayAttr:$indices
  );

  let results = (outs
    SPV_Composite:$result
  );

  let builders = [
    OpBuilderDAG<(ins "Value":$object, "Value":$composite,
      "ArrayRef<int32_t>":$indices)>
  ];
}

// -----

def SPV_VectorExtractDynamicOp : SPV_Op<"VectorExtractDynamic",
            [NoSideEffect,
            TypesMatchWith<"type of 'result' matches element type of 'vector'",
                     "vector", "result",
                     "$_self.cast<mlir::VectorType>().getElementType()">]> {
  let summary = [{
    Extract a single, dynamically selected, component of a vector.
  }];

  let description = [{
    Result Type must be a scalar type.

    Vector must have a type OpTypeVector whose Component Type is Result
    Type.

    Index must be a scalar integer. It is interpreted as a 0-based index of
    which component of Vector to extract.

    Behavior is undefined if Index's value is less than zero or greater than
    or equal to the number of components in Vector.

    <!-- End of AutoGen section -->

    ```
	scalar-type ::= integer-type | float-type | boolean-type 
    vector-extract-dynamic-op ::= `spv.VectorExtractDynamic ` ssa-use `[` ssa-use `]`
                                    `:` `vector<` integer-literal `x` scalar-type `>` `,`
                                    integer-type
    ```mlir

    #### Example:

    ```
    %2 = spv.VectorExtractDynamic %0[%1] : vector<8xf32>, i32
    ```
  }];

  let arguments = (ins
    SPV_Vector:$vector,
    SPV_Integer:$index
  );

  let results = (outs
    SPV_Scalar:$result
  );
  
  let verifier = [{ return success(); }];
  
  let assemblyFormat = [{
    $vector `[` $index `]` attr-dict `:` type($vector) `,` type($index) 
  }];
  
}

// -----

def SPV_VectorInsertDynamicOp : SPV_Op<"VectorInsertDynamic",
        [NoSideEffect,
        TypesMatchWith<"type of 'component' matches element type of 'vector'",
                "vector", "component",
                "$_self.cast<mlir::VectorType>().getElementType()">,
                AllTypesMatch<["vector", "result"]>]> {
  let summary = [{
    Make a copy of a vector, with a single, variably selected, component
    modified.
  }];

  let description = [{
    Result Type must be an OpTypeVector.

    Vector must have the same type as Result Type and is the vector that the
    non-written components are copied from.

    Component is the value supplied for the component selected by Index. It
    must have the same type as the type of components in Result Type.

    Index must be a scalar integer. It is interpreted as a 0-based index of
    which component to modify.

    Behavior is undefined if Index's value is less than zero or greater than
    or equal to the number of components in Vector.

    <!-- End of AutoGen section -->

    ```
    scalar-type ::= integer-type | float-type | boolean-type 
    vector-insert-dynamic-op ::= `spv.VectorInsertDynamic ` ssa-use `,`
                                  ssa-use `[` ssa-use `]`
                                  `:` `vector<` integer-literal `x` scalar-type `>` `,`
                                  integer-type
    ```mlir

    #### Example:

    ```
    %scalar = ... : f32
    %2 = spv.VectorInsertDynamic %scalar %0[%1] : f32, vector<8xf32>, i32
    ```
  }];

  let arguments = (ins
    SPV_Vector:$vector,
    SPV_Scalar:$component,
    SPV_Integer:$index
  );

  let results = (outs
    SPV_Vector:$result
  );
  
  let verifier = [{ return success(); }];
  
  let assemblyFormat = [{
    $component `,` $vector `[` $index `]` attr-dict `:` type($vector) `,` type($index) 
  }];
}

// -----

#endif // SPIRV_COMPOSITE_OPS
