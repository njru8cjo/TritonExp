import os, subprocess
import importlib.util
import sysconfig

def ceildiv(a, b):
    return -(a // -b)

def compile():
    # This function was renamed and made public in Python 3.10
    if hasattr(sysconfig, 'get_default_scheme'):
        scheme = sysconfig.get_default_scheme()
    else:
        scheme = sysconfig._get_default_scheme()
    # 'posix_local' is a custom scheme on Debian. However, starting Python 3.10, the default install
    # path changes to include 'local'. This change is required to use triton with system-wide python.
    if scheme == 'posix_local':
        scheme = 'posix_prefix'
    py_include_dir = sysconfig.get_paths(scheme=scheme)["include"]
    include_dir = "/home/ywshao/triton_shared/triton/.venv/lib/python3.12/site-packages/triton/backends/triton_shared/include"

    asm_src_path = os.path.join("/home/ywshao", "kernel.s")
    launcher_src_path = os.path.join("/home/ywshao", "main.cxx")

    # Compile it together.
    subprocess.check_call([
        "/home/ywshao/llvm-project/build/bin/clang", launcher_src_path, asm_src_path,
        "--target=riscv64-linux-gnu", "-march=rv64gc",
        "-I/usr/riscv64-linux-gnu/include", "-L/usr/riscv64-linux-gnu/lib",
        f"-I{py_include_dir}", f"-I{include_dir}",
        "-shared", "-fPIC", "-fopenmp", "-o", so_path, "-lstdc++"
    ])

def launch(gridX, gridY, gridZ, *args):
    name = "__triton_shared_ref_cpu_kernel_launcher"
    spec = importlib.util.spec_from_file_location(name, so_path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    mod.launch(gridX, gridY, gridZ,
               None, None,
               None, None,
               *args)

so_path = os.path.join("/home/ywshao", "kernel.so")
clang_path = os.path.join("/home/ywshao", "llvm-project/build/bin/clang")
compile()
