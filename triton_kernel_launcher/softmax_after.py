import driver
import torch

def softmax(x):
    n_rows, n_cols = x.shape
    BLOCK_SIZE = driver.next_power_of_2(n_cols)
    num_warps = 4
    if BLOCK_SIZE >= 2048:
        num_warps = 8
    if BLOCK_SIZE >= 4096:
        num_warps = 16
    y = torch.empty_like(x)
    driver.launch(n_rows, 1, 1, y, x, x.stride(0), y.stride(0), n_cols)
    return y

def test():
    torch.manual_seed(0)
    x = torch.randn(1823, 7810, device='cpu')
    triton_output = softmax(x)
    torch_output = torch.softmax(x, axis=1)
    assert torch.allclose(triton_output, torch_output), (triton_output, torch_output)
    print('ok')
test()