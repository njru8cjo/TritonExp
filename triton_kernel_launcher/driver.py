import os, subprocess
import importlib.util
import sysconfig

def ceildiv(a, b):
    return -(a // -b)

def next_power_of_2(a):
    if a == 1:
        return 1
    return int("1" + "0" * (len(bin(a - 1)) - 2), 2)

def compile():
    return
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
    include_dir = "/home/ywshao/Desktop/riscv/include"

    asm_src_path = os.path.join("/home/ywshao/Desktop/riscv", "bin.s")
    launcher_src_path = os.path.join("/home/ywshao/Desktop/riscv", "main.cxx")

    # Compile it together.
    subprocess.check_call([
        "clang", launcher_src_path, asm_src_path,
        f"-I{py_include_dir}", f"-I{include_dir}",
        "-shared", "-fPIC", "-fopenmp", "-o", so_path, "-lstdc++"
    ])

def launch(gridX, gridY, gridZ, *args):
    print(os.environ.get('LD_LIBRARY_PATH'))
    name = "__triton_shared_ref_cpu_kernel_launcher"
    spec = importlib.util.spec_from_file_location(name, so_path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    mod.launch(gridX, gridY, gridZ,
               None, None,
               None, None,
               *args)

so_path = os.path.join("/home/ywshao/Desktop/riscv", "kernel.so")
clang_path = os.path.join("clang")
#compile()
