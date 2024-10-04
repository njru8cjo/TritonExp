#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @matmul_kernel(%arg0: memref<*xf32> {tt.divisibility = 16 : i32}, %arg1: memref<*xf32> {tt.divisibility = 16 : i32}, %arg2: memref<*xf32> {tt.divisibility = 16 : i32}, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) {
    %c8_i32 = arith.constant 8 : i32
    %c32_i32 = arith.constant 32 : i32
    %c64_i32 = arith.constant 64 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %c31_i32 = arith.constant 31 : i32
    %c63_i32 = arith.constant 63 : i32
    %c15_i32 = arith.constant 15 : i32
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c16 = arith.constant 16 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32 = arith.constant 32 : index
    %c64 = arith.constant 64 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<32x64xf32>
    linalg.fill ins(%cst : f32) outs(%alloc : memref<32x64xf32>)
    %0 = arith.addi %arg3, %c31_i32 : i32
    %1 = arith.divsi %0, %c32_i32 : i32
    %2 = arith.addi %arg4, %c63_i32 : i32
    %3 = arith.divsi %2, %c64_i32 : i32
    %4 = arith.muli %3, %c8_i32 : i32
    %5 = arith.divsi %arg12, %4 : i32
    %6 = arith.muli %5, %c8_i32 : i32
    %7 = arith.subi %1, %6 : i32
    %8 = arith.minsi %7, %c8_i32 : i32
    %9 = arith.remsi %arg12, %8 : i32
    %10 = arith.addi %6, %9 : i32
    %11 = arith.remsi %arg12, %4 : i32
    %12 = arith.divsi %11, %8 : i32
    %13 = arith.muli %10, %c32_i32 : i32
    %14 = arith.index_cast %13 : i32 to index
    %15 = arith.muli %12, %c64_i32 : i32
    %16 = arith.index_cast %15 : i32 to index
    %17 = arith.index_cast %arg3 : i32 to index
    %18 = arith.index_cast %arg6 : i32 to index
    %19 = arith.muli %14, %18 : index
    %20 = arith.muli %17, %18 : index
    %21 = arith.index_cast %arg7 : i32 to index
    %22 = arith.index_cast %arg4 : i32 to index
    %23 = arith.addi %arg5, %c15_i32 : i32
    %24 = arith.divsi %23, %c16_i32 : i32
    %25 = arith.muli %arg7, %c16_i32 : i32
    %26 = arith.index_cast %25 : i32 to index
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<32x64xf32>
    memref.copy %alloc, %alloc_0 : memref<32x64xf32> to memref<32x64xf32>
    %27:3 = scf.for %arg15 = %c0_i32 to %24 step %c1_i32 iter_args(%arg16 = %alloc_0, %arg17 = %19, %arg18 = %c0) -> (memref<32x64xf32>, index, index)  : i32 {
      %39 = arith.addi %arg18, %16 : index
      %40 = arith.remsi %39, %22 : index
      %41 = arith.subi %39, %40 : index
      %42 = arith.addi %40, %c64 : index
      %43 = arith.minsi %42, %22 : index
      %44 = arith.subi %43, %40 : index
      %reinterpret_cast_2 = memref.reinterpret_cast %arg1 to offset: [%39], sizes: [%c16, %44], strides: [%21, %c1] : memref<*xf32> to memref<16x?xf32, strided<[?, ?], offset: ?>>
      %45 = arith.subi %c64, %44 : index
      %reinterpret_cast_3 = memref.reinterpret_cast %arg1 to offset: [%41], sizes: [%c16, %45], strides: [%21, %c1] : memref<*xf32> to memref<16x?xf32, strided<[?, ?], offset: ?>>
      %46 = arith.remsi %arg17, %18 : index
      %47 = arith.addi %20, %46 : index
      %48 = arith.subi %47, %arg17 : index
      %49 = arith.divsi %48, %18 : index
      %reinterpret_cast_4 = memref.reinterpret_cast %arg0 to offset: [%arg17], sizes: [%49, %c16], strides: [%18, %c1] : memref<*xf32> to memref<?x16xf32, strided<[?, ?], offset: ?>>
      %50 = arith.subi %c32, %49 : index
      %reinterpret_cast_5 = memref.reinterpret_cast %arg0 to offset: [%46], sizes: [%50, %c16], strides: [%18, %c1] : memref<*xf32> to memref<?x16xf32, strided<[?, ?], offset: ?>>
      %51 = arith.muli %arg15, %c16_i32 : i32
      %52 = arith.subi %arg5, %51 : i32
      %53 = arith.index_cast %52 : i32 to index
      %54 = arith.minsi %53, %c16 : index
      %alloc_6 = memref.alloc() : memref<32x16xf32>
      %55 = arith.cmpi slt, %54, %c16 : index
      scf.if %55 {
        %c0_17 = arith.constant 0 : index
        %c32_18 = arith.constant 32 : index
        %c1_19 = arith.constant 1 : index
        scf.for %arg19 = %c0_17 to %c32_18 step %c1_19 {
          %c0_20 = arith.constant 0 : index
          %c16_21 = arith.constant 16 : index
          %c1_22 = arith.constant 1 : index
          scf.for %arg20 = %c0_20 to %c16_21 step %c1_22 {
            memref.store %cst, %alloc_6[%arg19, %arg20] : memref<32x16xf32>
          }
        }
      }
      %56 = arith.minsi %49, %c32 : index
      %57 = arith.subi %c32, %56 : index
      %subview_7 = memref.subview %reinterpret_cast_4[0, 0] [%56, %54] [1, 1] : memref<?x16xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
      %subview_8 = memref.subview %reinterpret_cast_5[0, 0] [%57, %54] [1, 1] : memref<?x16xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
      %subview_9 = memref.subview %alloc_6[0, 0] [%56, %54] [1, 1] : memref<32x16xf32> to memref<?x?xf32, strided<[16, 1]>>
      %subview_10 = memref.subview %alloc_6[%56, 0] [%57, %54] [1, 1] : memref<32x16xf32> to memref<?x?xf32, strided<[16, 1], offset: ?>>
      memref.copy %subview_7, %subview_9 : memref<?x?xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[16, 1]>>
      memref.copy %subview_8, %subview_10 : memref<?x?xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[16, 1], offset: ?>>
      %alloc_11 = memref.alloc() : memref<16x64xf32>
      scf.if %55 {
        %c0_17 = arith.constant 0 : index
        %c16_18 = arith.constant 16 : index
        %c1_19 = arith.constant 1 : index
        scf.for %arg19 = %c0_17 to %c16_18 step %c1_19 {
          %c0_20 = arith.constant 0 : index
          %c64_21 = arith.constant 64 : index
          %c1_22 = arith.constant 1 : index
          scf.for %arg20 = %c0_20 to %c64_21 step %c1_22 {
            memref.store %cst, %alloc_11[%arg19, %arg20] : memref<16x64xf32>
          }
        }
      }
      %58 = arith.minsi %44, %c64 : index
      %59 = arith.subi %c64, %58 : index
      %subview_12 = memref.subview %reinterpret_cast_2[0, 0] [%54, %58] [1, 1] : memref<16x?xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
      %subview_13 = memref.subview %reinterpret_cast_3[0, 0] [%54, %59] [1, 1] : memref<16x?xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
      %subview_14 = memref.subview %alloc_11[0, 0] [%54, %58] [1, 1] : memref<16x64xf32> to memref<?x?xf32, strided<[64, 1]>>
      %subview_15 = memref.subview %alloc_11[0, %58] [%54, %59] [1, 1] : memref<16x64xf32> to memref<?x?xf32, strided<[64, 1], offset: ?>>
      memref.copy %subview_12, %subview_14 : memref<?x?xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[64, 1]>>
      memref.copy %subview_13, %subview_15 : memref<?x?xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[64, 1], offset: ?>>
      %alloc_16 = memref.alloc() {alignment = 64 : i64} : memref<32x64xf32>
      memref.copy %alloc, %alloc_16 : memref<32x64xf32> to memref<32x64xf32>
      linalg.matmul ins(%alloc_6, %alloc_11 : memref<32x16xf32>, memref<16x64xf32>) outs(%alloc_16 : memref<32x64xf32>)
      linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%alloc_16, %arg16 : memref<32x64xf32>, memref<32x64xf32>) outs(%alloc_16 : memref<32x64xf32>) {
      ^bb0(%in: f32, %in_17: f32, %out: f32):
        %62 = arith.addf %in, %in_17 : f32
        linalg.yield %62 : f32
      }
      %60 = arith.addi %arg17, %c16 : index
      %61 = arith.addi %arg18, %26 : index
      scf.yield %alloc_16, %60, %61 : memref<32x64xf32>, index, index
    }
    %28 = arith.index_cast %arg8 : i32 to index
    %29 = arith.muli %14, %28 : index
    %30 = arith.addi %29, %16 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [%30], sizes: [32, 64], strides: [%28, 1] : memref<*xf32> to memref<32x64xf32, strided<[?, 1], offset: ?>>
    %31 = arith.addi %14, %c32 : index
    %32 = arith.minsi %31, %17 : index
    %33 = arith.subi %32, %14 : index
    %34 = arith.addi %16, %c64 : index
    %35 = arith.minsi %34, %22 : index
    %36 = arith.subi %35, %16 : index
    %37 = arith.minsi %33, %c32 : index
    %38 = arith.minsi %36, %c64 : index
    %subview = memref.subview %27#0[0, 0] [%37, %38] [1, 1] : memref<32x64xf32> to memref<?x?xf32, strided<[64, 1]>>
    %subview_1 = memref.subview %reinterpret_cast[0, 0] [%37, %38] [1, 1] : memref<32x64xf32, strided<[?, 1], offset: ?>> to memref<?x?xf32, strided<[?, 1], offset: ?>>
    memref.copy %subview, %subview_1 : memref<?x?xf32, strided<[64, 1]>> to memref<?x?xf32, strided<[?, 1], offset: ?>>
    return
  }
}

