import driver
import torch

def matmul(a, b, activation=''):
    assert a.shape[1] == b.shape[0], 'Incompatible dimensions'
    assert a.is_contiguous(), 'Matrix A must be contiguous'
    assert b.is_contiguous(), 'Matrix B must be contiguous'
    M, K = a.shape
    K, N = b.shape
    c = torch.empty((M, N), device=a.device, dtype=a.dtype)
    grid = driver.ceildiv(M, 32) * driver.ceildiv(N, 64)
    driver.launch(grid, 1, 1, a, b, c, M, N, K, a.stride(0), a.stride(1), b.stride(0), b.stride(1), c.stride(0), c.stride(1))
    return c

def test():
    torch.manual_seed(0)
    rows1 = 1790
    cols1 = 1670
    rows2 = 1670
    cols2 = 321
    a = torch.randn((rows1, cols1), device='cpu', dtype=torch.float32)
    b = torch.randn((rows2, cols2), device='cpu', dtype=torch.float32)
    triton_output = matmul(a, b)
    torch_output = torch.matmul(a, b)
    print(f'triton_output={triton_output}')
    print(f'torch_output={torch_output}')
    if torch.allclose(triton_output, torch_output, atol=0.01, rtol=0):
        print('✅ Triton and Torch match')
    else:
        print('❌ Triton and Torch differ')
test()