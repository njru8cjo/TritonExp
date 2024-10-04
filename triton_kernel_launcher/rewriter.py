'''
This script only supports single kernel currently and does not always work.
To support multiple kernels,
it needs to support multiple kernel srcs in driver.py
and scope analysis in rewriter.py (this file).
'''
import sys
import os
from pathlib import Path
import ast

# Remove the following lines
# import triton
# import triton.language as tl
class RemoveTritonImport(ast.NodeTransformer):
    def visit_Import(self, node):
        node.names = [alias for alias in node.names if alias.name != "triton" and alias.name != "triton.language"]
        return node
    def visit_ImportFrom(self, node):
        if node.module.startswith("triton"):
            return None
        return node

# Remove the following lines
# import
class RemoveEmptyImport(ast.NodeTransformer):
    def visit_Import(self, node):
        if not node.names:
            return None
        return node

# Remove the following lines
# triton.runtime.driver.set_active(CPUDriver())
class RemoveTritonExpression(ast.NodeTransformer):
    def visit_Expr(self, node):
        # Declare variables to beautify the following mess
        if not hasattr(node, "value"):
            return node
        if not hasattr(node.value, "func"):
            return node
        if not hasattr(node.value.func, "value"):
            return node
        if not hasattr(node.value.func.value, "value"):
            return node
        if not hasattr(node.value.func.value.value, "value"):
            return node
        if not hasattr(node.value.func.value.value.value, "id"):
            return node
        if node.value.func.value.value.value.id == "triton":
            return None
        return node

# Remove the following lines
# @triton.jit
# def xxx_kernel(...): ...
class RemoveTritonFunctionDefinition(ast.NodeTransformer):
    def visit_FunctionDef(self, node):
        if not node.decorator_list:
            return node
        for element in node.decorator_list:
            if not hasattr(element, "value"):
                return node
            if not hasattr(element.value, "id"):
                return node
            if element.value.id == "triton":
                global removedFunctions
                removedFunctions += [node.name]
                return None
        return node

# Rewrite the following lines
# xxx_kernel[a](b, BLOCK_SIZE=1024)
# -> driver.launch(a, b)
class RewriteKernel(ast.NodeTransformer):
    def visit_Expr(self, node):
        if not hasattr(node, "value"):
            return node
        if not hasattr(node.value, "func"):
            return node
        if not hasattr(node.value.func, "value"):
            return node
        if not hasattr(node.value.func.value, "id"):
            return node
        if node.value.func.value.id in removedFunctions:
            node.value.func = ast.Attribute(value=ast.Name(id="driver", ctx=ast.Load()),
                                            attr="launch",
                                            ctx=ast.Load())
            node.value.args = [ast.Name(id='grid', ctx=ast.Load())] + [ast.Constant(value=1)] * 2 + node.value.args
            for element in node.value.keywords:
                if hasattr(element.value, "value"):
                    removedConstant[element.arg] = element.value.value
                else:
                    print("Please fix the following variable: " + element.arg)
            node.value.keywords = []
            return node
        return node

'''
                Expr(
                    value=Call(
                        func=Subscript(
                            value=Name(id='add_kernel', ctx=Load()),
                            slice=Name(id='grid', ctx=Load()),
                            ctx=Load()),
                        args=[
                            Name(id='x', ctx=Load()),
                            Name(id='y', ctx=Load()),
                            Name(id='output', ctx=Load()),
                            Name(id='n_elements', ctx=Load())],
                        keywords=[
                            keyword(
                                arg='BLOCK_SIZE',
                                value=Constant(value=1024))])),
                Return(
                    value=Name(id='output', ctx=Load()))]
'''
# Remember to extract BLOCK_SIZE
'''
                Expr(
                    value=Call(
                        func=Attribute(
                            value=Name(id='driver', ctx=Load()),
                            attr='launch',
                            ctx=Load()),
                        args=[
                            Name(id='x', ctx=Load()),
                            Name(id='y', ctx=Load()),
                            Name(id='output', ctx=Load()),
                            Name(id='n_elements', ctx=Load())],
'''

# Rewrite the following lines
# grid = lambda meta: (triton.cdiv(n_elements, meta['BLOCK_SIZE']),)
# -> grid = driver.ceildiv(n_elements, xxx)
class RewriteCeilDiv(ast.NodeTransformer):
    def visit_Assign(self, node):
        callFunction = False
        if not hasattr(node, "value"):
            return node
        if not hasattr(node.value, "body"):
            return node
        if not hasattr(node.value.body, "elts"):
            return node
        for call in node.value.body.elts:
            if not hasattr(call, "func"):
                continue
            if not hasattr(call.func, "value"):
                continue
            if not hasattr(call.func.value, "id") or not call.func.value.id == "triton":
                continue
            if not hasattr(call.func, "attr") or not call.func.attr == "cdiv":
                continue
            if not hasattr(call, "args"):
                continue
            # call.args seems to be immutable, and we cannot use "for x in call.args" to modify it
            for index in range(len(call.args)):
                element = call.args[index]
                if not hasattr(element, "slice"):
                    continue
                if not hasattr(element.slice, "value") or not element.slice.value in removedConstant:
                    continue
                call.args[index] = ast.Constant(value=removedConstant[element.slice.value])
                break
            call.func.value.id = "driver"
            call.func.attr = "ceildiv"
            callFunction = call
            continue
        if callFunction:
            node.value = callFunction
        return node

# Rewrite the following lines
# BLOCK_SIZE = triton.next_power_of_2(n_cols)
# -> BLOCK_SIZE = driver.next_power_of_2(n_cols)
class RewriteNext_power_of_2(ast.NodeTransformer):
    def visit_Assign(self, node):
        callFunction = False
        if not hasattr(node, "value"):
            return node
        if True:
            if not hasattr(node.value, "func"):
                return node
            if not hasattr(node.value.func, "value"):
                return node
            if not hasattr(node.value.func.value, "id") or not node.value.func.value.id == "triton":
                return node
            if not hasattr(node.value.func, "attr") or not node.value.func.attr == "next_power_of_2":
                return node
            if not hasattr(node.value, "args"):
                return node
            for index in range(len(node.value.args)):
                element = node.value.args[index]
                if not hasattr(element, "slice"):
                    continue
                if not hasattr(element.slice, "value") or not element.slice.value in removedConstant:
                    continue
                node.value.args[index] = ast.Constant(value=removedConstant[element.slice.value])
                break
            node.value.func.value.id = "driver"
            node.value.func.attr = "next_power_of_2"
            callFunction = node.value
            return node
        if callFunction:
            node.value = callFunction
        return node

'''
        Assign(
            targets=[
                Name(id='grid', ctx=Store())],
            value=Lambda(
                args=arguments(
                    posonlyargs=[],
                    args=[
                        arg(arg='meta')],
                    kwonlyargs=[],
                    kw_defaults=[],
                    defaults=[]),
                body=Tuple(
                    elts=[
                        Call(
                            func=Attribute(
                                value=Name(id='triton', ctx=Load()),
                                attr='cdiv',
                                ctx=Load()),
                            args=[
                                Name(id='n_elements', ctx=Load()),
                                Subscript(
                                    value=Name(id='meta', ctx=Load()),
                                    slice=Constant(value='BLOCK_SIZE'),
                                    ctx=Load())],
                            keywords=[])],
                    ctx=Load()))),

        Assign(
            targets=[
                Name(id='grid', ctx=Store())],
            value=Call(
                func=Attribute(
                    value=Name(id='driver', ctx=Load()),
                    attr='ceildiv',
                    ctx=Load()),
                args=[
                    Name(id='n_elements', ctx=Load()),
                    Constant(value=1024)],
                keywords=[]))],
'''

removedFunctions = []
removedConstant = {}

fin = open(sys.argv[1], "r")
fout = open(sys.argv[2], "w")

astObj = ast.parse("import driver\n" + fin.read())
stages = [RemoveTritonImport(),
          RemoveEmptyImport(),
          RemoveTritonExpression(),
          RemoveTritonFunctionDefinition(),
          RewriteKernel(),
          RewriteCeilDiv(),
          RewriteNext_power_of_2()]
for stage in stages:
    stage.visit(astObj)

#print(ast.dump(astObj, indent=4))

fout.write(ast.unparse(astObj))

print("Please check if grid and lambda need to be fixed.")

'''
removingTritonJit = False

fout.write("import driver")

for line in fin.readlines():
    if removingTritonJit:
        if line.startswith("def") or line.startswith("):") or line.startswith(" ") or line.startswith("\t"):
            continue
        else:
            removingTritonJit = False
    elif "import triton" in line:
        continue
    elif "from triton" in line:
        continue
    elif "triton.runtime" in line:
        continue
    elif "@triton.jit" in line:
        removingTritonJit = True
    else:
        fout.write(line)
'''