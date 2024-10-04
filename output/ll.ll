; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare void @memrefCopy(i64, ptr, ptr)

declare ptr @malloc(i64)

define void @matmul_kernel(i64 %0, ptr %1, i64 %2, ptr %3, i64 %4, ptr %5, i32 %6, i32 %7, i32 %8, i32 %9, i32 %10, i32 %11, i32 %12, i32 %13, i32 %14, i32 %15, i32 %16, i32 %17) {
  %19 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 2048) to i64), i64 64))
  %20 = ptrtoint ptr %19 to i64
  %21 = add i64 %20, 63
  %22 = urem i64 %21, 64
  %23 = sub i64 %21, %22
  %24 = inttoptr i64 %23 to ptr
  br label %25

25:                                               ; preds = %37, %18
  %26 = phi i64 [ %38, %37 ], [ 0, %18 ]
  %27 = icmp slt i64 %26, 32
  br i1 %27, label %28, label %39

28:                                               ; preds = %25
  br label %29

29:                                               ; preds = %32, %28
  %30 = phi i64 [ %36, %32 ], [ 0, %28 ]
  %31 = icmp slt i64 %30, 64
  br i1 %31, label %32, label %37

32:                                               ; preds = %29
  %33 = mul i64 %26, 64
  %34 = add i64 %33, %30
  %35 = getelementptr float, ptr %24, i64 %34
  store float 0.000000e+00, ptr %35, align 4
  %36 = add i64 %30, 1
  br label %29

37:                                               ; preds = %29
  %38 = add i64 %26, 1
  br label %25

39:                                               ; preds = %25
  %40 = add i32 %6, 31
  %41 = sdiv i32 %40, 32
  %42 = add i32 %7, 63
  %43 = sdiv i32 %42, 64
  %44 = mul i32 %43, 8
  %45 = sdiv i32 %15, %44
  %46 = mul i32 %45, 8
  %47 = sub i32 %41, %46
  %48 = call i32 @llvm.smin.i32(i32 %47, i32 8)
  %49 = srem i32 %15, %48
  %50 = add i32 %46, %49
  %51 = srem i32 %15, %44
  %52 = sdiv i32 %51, %48
  %53 = mul i32 %50, 32
  %54 = sext i32 %53 to i64
  %55 = mul i32 %52, 64
  %56 = sext i32 %55 to i64
  %57 = sext i32 %6 to i64
  %58 = sext i32 %9 to i64
  %59 = mul i64 %54, %58
  %60 = mul i64 %57, %58
  %61 = sext i32 %10 to i64
  %62 = sext i32 %7 to i64
  %63 = add i32 %8, 15
  %64 = sdiv i32 %63, 16
  %65 = mul i32 %10, 16
  %66 = sext i32 %65 to i64
  %67 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 2048) to i64), i64 64))
  %68 = ptrtoint ptr %67 to i64
  %69 = add i64 %68, 63
  %70 = urem i64 %69, 64
  %71 = sub i64 %69, %70
  %72 = inttoptr i64 %71 to ptr
  %73 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %67, 0
  %74 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %73, ptr %72, 1
  %75 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %74, i64 0, 2
  %76 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %75, i64 32, 3, 0
  %77 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %76, i64 64, 3, 1
  %78 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %77, i64 64, 4, 0
  %79 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %78, i64 1, 4, 1
  call void @llvm.memcpy.p0.p0.i64(ptr %72, ptr %24, i64 mul (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 1) to i64), i64 2048), i1 false)
  br label %80

80:                                               ; preds = %379, %39
  %81 = phi i32 [ %382, %379 ], [ 0, %39 ]
  %82 = phi { ptr, ptr, i64, [2 x i64], [2 x i64] } [ %319, %379 ], [ %79, %39 ]
  %83 = phi i64 [ %380, %379 ], [ %59, %39 ]
  %84 = phi i64 [ %381, %379 ], [ 0, %39 ]
  %85 = icmp slt i32 %81, %64
  br i1 %85, label %86, label %383

86:                                               ; preds = %80
  %87 = add i64 %84, %56
  %88 = srem i64 %87, %62
  %89 = sub i64 %87, %88
  %90 = add i64 %88, 64
  %91 = call i64 @llvm.smin.i64(i64 %90, i64 %62)
  %92 = sub i64 %91, %88
  %93 = load ptr, ptr %3, align 8
  %94 = getelementptr ptr, ptr %3, i32 1
  %95 = load ptr, ptr %94, align 8
  %96 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %93, 0
  %97 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %96, ptr %95, 1
  %98 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %97, i64 %87, 2
  %99 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %98, i64 16, 3, 0
  %100 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %99, i64 %61, 4, 0
  %101 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %100, i64 %92, 3, 1
  %102 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %101, i64 1, 4, 1
  %103 = sub i64 64, %92
  %104 = load ptr, ptr %3, align 8
  %105 = getelementptr ptr, ptr %3, i32 1
  %106 = load ptr, ptr %105, align 8
  %107 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %104, 0
  %108 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %107, ptr %106, 1
  %109 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %108, i64 %89, 2
  %110 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %109, i64 16, 3, 0
  %111 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %110, i64 %61, 4, 0
  %112 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %111, i64 %103, 3, 1
  %113 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %112, i64 1, 4, 1
  %114 = srem i64 %83, %58
  %115 = add i64 %60, %114
  %116 = sub i64 %115, %83
  %117 = sdiv i64 %116, %58
  %118 = load ptr, ptr %1, align 8
  %119 = getelementptr ptr, ptr %1, i32 1
  %120 = load ptr, ptr %119, align 8
  %121 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %118, 0
  %122 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %121, ptr %120, 1
  %123 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %122, i64 %83, 2
  %124 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %123, i64 %117, 3, 0
  %125 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %124, i64 %58, 4, 0
  %126 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %125, i64 16, 3, 1
  %127 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %126, i64 1, 4, 1
  %128 = sub i64 32, %117
  %129 = load ptr, ptr %1, align 8
  %130 = getelementptr ptr, ptr %1, i32 1
  %131 = load ptr, ptr %130, align 8
  %132 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %129, 0
  %133 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %132, ptr %131, 1
  %134 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %133, i64 %114, 2
  %135 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %134, i64 %128, 3, 0
  %136 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %135, i64 %58, 4, 0
  %137 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %136, i64 16, 3, 1
  %138 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %137, i64 1, 4, 1
  %139 = mul i32 %81, 16
  %140 = sub i32 %8, %139
  %141 = sext i32 %140 to i64
  %142 = call i64 @llvm.smin.i64(i64 %141, i64 16)
  %143 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (float, ptr null, i32 512) to i64))
  %144 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %143, 0
  %145 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %144, ptr %143, 1
  %146 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %145, i64 0, 2
  %147 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %146, i64 32, 3, 0
  %148 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %147, i64 16, 3, 1
  %149 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %148, i64 16, 4, 0
  %150 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %149, i64 1, 4, 1
  %151 = icmp slt i64 %142, 16
  br i1 %151, label %152, label %168

152:                                              ; preds = %86
  br label %153

153:                                              ; preds = %165, %152
  %154 = phi i64 [ %166, %165 ], [ 0, %152 ]
  %155 = icmp slt i64 %154, 32
  br i1 %155, label %156, label %167

156:                                              ; preds = %153
  br label %157

157:                                              ; preds = %160, %156
  %158 = phi i64 [ %164, %160 ], [ 0, %156 ]
  %159 = icmp slt i64 %158, 16
  br i1 %159, label %160, label %165

160:                                              ; preds = %157
  %161 = mul i64 %154, 16
  %162 = add i64 %161, %158
  %163 = getelementptr float, ptr %143, i64 %162
  store float 0.000000e+00, ptr %163, align 4
  %164 = add i64 %158, 1
  br label %157

165:                                              ; preds = %157
  %166 = add i64 %154, 1
  br label %153

167:                                              ; preds = %153
  br label %168

168:                                              ; preds = %167, %86
  %169 = call i64 @llvm.smin.i64(i64 %117, i64 32)
  %170 = sub i64 32, %169
  %171 = insertvalue { ptr, ptr, i64 } undef, ptr %118, 0
  %172 = insertvalue { ptr, ptr, i64 } %171, ptr %120, 1
  %173 = insertvalue { ptr, ptr, i64 } %172, i64 0, 2
  %174 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %118, 0
  %175 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %174, ptr %120, 1
  %176 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %175, i64 %83, 2
  %177 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %176, i64 %169, 3, 0
  %178 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %177, i64 %58, 4, 0
  %179 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %178, i64 %142, 3, 1
  %180 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %179, i64 1, 4, 1
  %181 = insertvalue { ptr, ptr, i64 } undef, ptr %129, 0
  %182 = insertvalue { ptr, ptr, i64 } %181, ptr %131, 1
  %183 = insertvalue { ptr, ptr, i64 } %182, i64 0, 2
  %184 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %129, 0
  %185 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %184, ptr %131, 1
  %186 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %185, i64 %114, 2
  %187 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %186, i64 %170, 3, 0
  %188 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %187, i64 %58, 4, 0
  %189 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %188, i64 %142, 3, 1
  %190 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %189, i64 1, 4, 1
  %191 = insertvalue { ptr, ptr, i64 } undef, ptr %143, 0
  %192 = insertvalue { ptr, ptr, i64 } %191, ptr %143, 1
  %193 = insertvalue { ptr, ptr, i64 } %192, i64 0, 2
  %194 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %143, 0
  %195 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %194, ptr %143, 1
  %196 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %195, i64 0, 2
  %197 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %196, i64 %169, 3, 0
  %198 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %197, i64 16, 4, 0
  %199 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %198, i64 %142, 3, 1
  %200 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %199, i64 1, 4, 1
  %201 = insertvalue { ptr, ptr, i64 } undef, ptr %143, 0
  %202 = insertvalue { ptr, ptr, i64 } %201, ptr %143, 1
  %203 = insertvalue { ptr, ptr, i64 } %202, i64 0, 2
  %204 = mul i64 %169, 16
  %205 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %143, 0
  %206 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %205, ptr %143, 1
  %207 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %206, i64 %204, 2
  %208 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %207, i64 %170, 3, 0
  %209 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %208, i64 16, 4, 0
  %210 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %209, i64 %142, 3, 1
  %211 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %210, i64 1, 4, 1
  %212 = call ptr @llvm.stacksave.p0()
  %213 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [2 x i64], [2 x i64] } %180, ptr %213, align 8
  %214 = insertvalue { i64, ptr } { i64 2, ptr undef }, ptr %213, 1
  %215 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [2 x i64], [2 x i64] } %200, ptr %215, align 8
  %216 = insertvalue { i64, ptr } { i64 2, ptr undef }, ptr %215, 1
  %217 = alloca { i64, ptr }, i64 1, align 8
  store { i64, ptr } %214, ptr %217, align 8
  %218 = alloca { i64, ptr }, i64 1, align 8
  store { i64, ptr } %216, ptr %218, align 8
  call void @memrefCopy(i64 ptrtoint (ptr getelementptr (float, ptr null, i32 1) to i64), ptr %217, ptr %218)
  call void @llvm.stackrestore.p0(ptr %212)
  %219 = call ptr @llvm.stacksave.p0()
  %220 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [2 x i64], [2 x i64] } %190, ptr %220, align 8
  %221 = insertvalue { i64, ptr } { i64 2, ptr undef }, ptr %220, 1
  %222 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [2 x i64], [2 x i64] } %211, ptr %222, align 8
  %223 = insertvalue { i64, ptr } { i64 2, ptr undef }, ptr %222, 1
  %224 = alloca { i64, ptr }, i64 1, align 8
  store { i64, ptr } %221, ptr %224, align 8
  %225 = alloca { i64, ptr }, i64 1, align 8
  store { i64, ptr } %223, ptr %225, align 8
  call void @memrefCopy(i64 ptrtoint (ptr getelementptr (float, ptr null, i32 1) to i64), ptr %224, ptr %225)
  call void @llvm.stackrestore.p0(ptr %219)
  %226 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (float, ptr null, i32 1024) to i64))
  %227 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %226, 0
  %228 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %227, ptr %226, 1
  %229 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %228, i64 0, 2
  %230 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %229, i64 16, 3, 0
  %231 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %230, i64 64, 3, 1
  %232 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %231, i64 64, 4, 0
  %233 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %232, i64 1, 4, 1
  br i1 %151, label %234, label %250

234:                                              ; preds = %168
  br label %235

235:                                              ; preds = %247, %234
  %236 = phi i64 [ %248, %247 ], [ 0, %234 ]
  %237 = icmp slt i64 %236, 16
  br i1 %237, label %238, label %249

238:                                              ; preds = %235
  br label %239

239:                                              ; preds = %242, %238
  %240 = phi i64 [ %246, %242 ], [ 0, %238 ]
  %241 = icmp slt i64 %240, 64
  br i1 %241, label %242, label %247

242:                                              ; preds = %239
  %243 = mul i64 %236, 64
  %244 = add i64 %243, %240
  %245 = getelementptr float, ptr %226, i64 %244
  store float 0.000000e+00, ptr %245, align 4
  %246 = add i64 %240, 1
  br label %239

247:                                              ; preds = %239
  %248 = add i64 %236, 1
  br label %235

249:                                              ; preds = %235
  br label %250

250:                                              ; preds = %249, %168
  %251 = call i64 @llvm.smin.i64(i64 %92, i64 64)
  %252 = sub i64 64, %251
  %253 = insertvalue { ptr, ptr, i64 } undef, ptr %93, 0
  %254 = insertvalue { ptr, ptr, i64 } %253, ptr %95, 1
  %255 = insertvalue { ptr, ptr, i64 } %254, i64 0, 2
  %256 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %93, 0
  %257 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %256, ptr %95, 1
  %258 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %257, i64 %87, 2
  %259 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %258, i64 %142, 3, 0
  %260 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %259, i64 %61, 4, 0
  %261 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %260, i64 %251, 3, 1
  %262 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %261, i64 1, 4, 1
  %263 = insertvalue { ptr, ptr, i64 } undef, ptr %104, 0
  %264 = insertvalue { ptr, ptr, i64 } %263, ptr %106, 1
  %265 = insertvalue { ptr, ptr, i64 } %264, i64 0, 2
  %266 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %104, 0
  %267 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %266, ptr %106, 1
  %268 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %267, i64 %89, 2
  %269 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %268, i64 %142, 3, 0
  %270 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %269, i64 %61, 4, 0
  %271 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %270, i64 %252, 3, 1
  %272 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %271, i64 1, 4, 1
  %273 = insertvalue { ptr, ptr, i64 } undef, ptr %226, 0
  %274 = insertvalue { ptr, ptr, i64 } %273, ptr %226, 1
  %275 = insertvalue { ptr, ptr, i64 } %274, i64 0, 2
  %276 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %226, 0
  %277 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %276, ptr %226, 1
  %278 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %277, i64 0, 2
  %279 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %278, i64 %142, 3, 0
  %280 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %279, i64 64, 4, 0
  %281 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %280, i64 %251, 3, 1
  %282 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %281, i64 1, 4, 1
  %283 = insertvalue { ptr, ptr, i64 } undef, ptr %226, 0
  %284 = insertvalue { ptr, ptr, i64 } %283, ptr %226, 1
  %285 = insertvalue { ptr, ptr, i64 } %284, i64 0, 2
  %286 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %226, 0
  %287 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %286, ptr %226, 1
  %288 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %287, i64 %251, 2
  %289 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %288, i64 %142, 3, 0
  %290 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %289, i64 64, 4, 0
  %291 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %290, i64 %252, 3, 1
  %292 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %291, i64 1, 4, 1
  %293 = call ptr @llvm.stacksave.p0()
  %294 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [2 x i64], [2 x i64] } %262, ptr %294, align 8
  %295 = insertvalue { i64, ptr } { i64 2, ptr undef }, ptr %294, 1
  %296 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [2 x i64], [2 x i64] } %282, ptr %296, align 8
  %297 = insertvalue { i64, ptr } { i64 2, ptr undef }, ptr %296, 1
  %298 = alloca { i64, ptr }, i64 1, align 8
  store { i64, ptr } %295, ptr %298, align 8
  %299 = alloca { i64, ptr }, i64 1, align 8
  store { i64, ptr } %297, ptr %299, align 8
  call void @memrefCopy(i64 ptrtoint (ptr getelementptr (float, ptr null, i32 1) to i64), ptr %298, ptr %299)
  call void @llvm.stackrestore.p0(ptr %293)
  %300 = call ptr @llvm.stacksave.p0()
  %301 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [2 x i64], [2 x i64] } %272, ptr %301, align 8
  %302 = insertvalue { i64, ptr } { i64 2, ptr undef }, ptr %301, 1
  %303 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [2 x i64], [2 x i64] } %292, ptr %303, align 8
  %304 = insertvalue { i64, ptr } { i64 2, ptr undef }, ptr %303, 1
  %305 = alloca { i64, ptr }, i64 1, align 8
  store { i64, ptr } %302, ptr %305, align 8
  %306 = alloca { i64, ptr }, i64 1, align 8
  store { i64, ptr } %304, ptr %306, align 8
  call void @memrefCopy(i64 ptrtoint (ptr getelementptr (float, ptr null, i32 1) to i64), ptr %305, ptr %306)
  call void @llvm.stackrestore.p0(ptr %300)
  %307 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 2048) to i64), i64 64))
  %308 = ptrtoint ptr %307 to i64
  %309 = add i64 %308, 63
  %310 = urem i64 %309, 64
  %311 = sub i64 %309, %310
  %312 = inttoptr i64 %311 to ptr
  %313 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %307, 0
  %314 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %313, ptr %312, 1
  %315 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %314, i64 0, 2
  %316 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %315, i64 32, 3, 0
  %317 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %316, i64 64, 3, 1
  %318 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %317, i64 64, 4, 0
  %319 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %318, i64 1, 4, 1
  call void @llvm.memcpy.p0.p0.i64(ptr %312, ptr %24, i64 mul (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 1) to i64), i64 2048), i1 false)
  br label %320

320:                                              ; preds = %352, %250
  %321 = phi i64 [ %353, %352 ], [ 0, %250 ]
  %322 = icmp slt i64 %321, 32
  br i1 %322, label %323, label %354

323:                                              ; preds = %320
  br label %324

324:                                              ; preds = %350, %323
  %325 = phi i64 [ %351, %350 ], [ 0, %323 ]
  %326 = icmp slt i64 %325, 64
  br i1 %326, label %327, label %352

327:                                              ; preds = %324
  br label %328

328:                                              ; preds = %331, %327
  %329 = phi i64 [ %349, %331 ], [ 0, %327 ]
  %330 = icmp slt i64 %329, 16
  br i1 %330, label %331, label %350

331:                                              ; preds = %328
  %332 = mul i64 %321, 16
  %333 = add i64 %332, %329
  %334 = getelementptr float, ptr %143, i64 %333
  %335 = load float, ptr %334, align 4
  %336 = mul i64 %329, 64
  %337 = add i64 %336, %325
  %338 = getelementptr float, ptr %226, i64 %337
  %339 = load float, ptr %338, align 4
  %340 = mul i64 %321, 64
  %341 = add i64 %340, %325
  %342 = getelementptr float, ptr %312, i64 %341
  %343 = load float, ptr %342, align 4
  %344 = fmul float %335, %339
  %345 = fadd float %343, %344
  %346 = mul i64 %321, 64
  %347 = add i64 %346, %325
  %348 = getelementptr float, ptr %312, i64 %347
  store float %345, ptr %348, align 4
  %349 = add i64 %329, 1
  br label %328

350:                                              ; preds = %328
  %351 = add i64 %325, 1
  br label %324

352:                                              ; preds = %324
  %353 = add i64 %321, 1
  br label %320

354:                                              ; preds = %320
  br label %355

355:                                              ; preds = %377, %354
  %356 = phi i64 [ %378, %377 ], [ 0, %354 ]
  %357 = icmp slt i64 %356, 32
  br i1 %357, label %358, label %379

358:                                              ; preds = %355
  br label %359

359:                                              ; preds = %362, %358
  %360 = phi i64 [ %376, %362 ], [ 0, %358 ]
  %361 = icmp slt i64 %360, 64
  br i1 %361, label %362, label %377

362:                                              ; preds = %359
  %363 = mul i64 %356, 64
  %364 = add i64 %363, %360
  %365 = getelementptr float, ptr %312, i64 %364
  %366 = load float, ptr %365, align 4
  %367 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %82, 1
  %368 = mul i64 %356, 64
  %369 = add i64 %368, %360
  %370 = getelementptr float, ptr %367, i64 %369
  %371 = load float, ptr %370, align 4
  %372 = fadd float %366, %371
  %373 = mul i64 %356, 64
  %374 = add i64 %373, %360
  %375 = getelementptr float, ptr %312, i64 %374
  store float %372, ptr %375, align 4
  %376 = add i64 %360, 1
  br label %359

377:                                              ; preds = %359
  %378 = add i64 %356, 1
  br label %355

379:                                              ; preds = %355
  %380 = add i64 %83, 16
  %381 = add i64 %84, %66
  %382 = add i32 %81, 1
  br label %80

383:                                              ; preds = %80
  %384 = sext i32 %11 to i64
  %385 = mul i64 %54, %384
  %386 = add i64 %385, %56
  %387 = load ptr, ptr %5, align 8
  %388 = getelementptr ptr, ptr %5, i32 1
  %389 = load ptr, ptr %388, align 8
  %390 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %387, 0
  %391 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %390, ptr %389, 1
  %392 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %391, i64 %386, 2
  %393 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %392, i64 32, 3, 0
  %394 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %393, i64 %384, 4, 0
  %395 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %394, i64 64, 3, 1
  %396 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %395, i64 1, 4, 1
  %397 = add i64 %54, 32
  %398 = call i64 @llvm.smin.i64(i64 %397, i64 %57)
  %399 = sub i64 %398, %54
  %400 = add i64 %56, 64
  %401 = call i64 @llvm.smin.i64(i64 %400, i64 %62)
  %402 = sub i64 %401, %56
  %403 = call i64 @llvm.smin.i64(i64 %399, i64 32)
  %404 = call i64 @llvm.smin.i64(i64 %402, i64 64)
  %405 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %82, 0
  %406 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %82, 1
  %407 = insertvalue { ptr, ptr, i64 } undef, ptr %405, 0
  %408 = insertvalue { ptr, ptr, i64 } %407, ptr %406, 1
  %409 = insertvalue { ptr, ptr, i64 } %408, i64 0, 2
  %410 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %82, 2
  %411 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %82, 3, 0
  %412 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %82, 3, 1
  %413 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %82, 4, 0
  %414 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %82, 4, 1
  %415 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %405, 0
  %416 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %415, ptr %406, 1
  %417 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %416, i64 0, 2
  %418 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %417, i64 %403, 3, 0
  %419 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %418, i64 64, 4, 0
  %420 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %419, i64 %404, 3, 1
  %421 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %420, i64 1, 4, 1
  %422 = insertvalue { ptr, ptr, i64 } undef, ptr %387, 0
  %423 = insertvalue { ptr, ptr, i64 } %422, ptr %389, 1
  %424 = insertvalue { ptr, ptr, i64 } %423, i64 0, 2
  %425 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %387, 0
  %426 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %425, ptr %389, 1
  %427 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %426, i64 %386, 2
  %428 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %427, i64 %403, 3, 0
  %429 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %428, i64 %384, 4, 0
  %430 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %429, i64 %404, 3, 1
  %431 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %430, i64 1, 4, 1
  %432 = call ptr @llvm.stacksave.p0()
  %433 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [2 x i64], [2 x i64] } %421, ptr %433, align 8
  %434 = insertvalue { i64, ptr } { i64 2, ptr undef }, ptr %433, 1
  %435 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [2 x i64], [2 x i64] } %431, ptr %435, align 8
  %436 = insertvalue { i64, ptr } { i64 2, ptr undef }, ptr %435, 1
  %437 = alloca { i64, ptr }, i64 1, align 8
  store { i64, ptr } %434, ptr %437, align 8
  %438 = alloca { i64, ptr }, i64 1, align 8
  store { i64, ptr } %436, ptr %438, align 8
  call void @memrefCopy(i64 ptrtoint (ptr getelementptr (float, ptr null, i32 1) to i64), ptr %437, ptr %438)
  call void @llvm.stackrestore.p0(ptr %432)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #0

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smin.i64(i64, i64) #0

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare ptr @llvm.stacksave.p0() #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.stackrestore.p0(ptr) #2

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind willreturn }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
