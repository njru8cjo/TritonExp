import driver
import torch

def add(x: torch.Tensor, y: torch.Tensor):
    output = torch.empty_like(x)
    n_elements = output.numel()
    grid = driver.ceildiv(n_elements, 1024)
    driver.launch(grid, 1, 1, x, y, output, n_elements)
    return output

def test():
    torch.manual_seed(0)
    size = 9843200
    x = torch.rand(size, device='cpu')
    y = torch.rand(size, device='cpu')
    torch_output = x + y
    triton_output = add(x, y)
    print('expected', torch_output)
    print('actual', triton_output)
    print(f'The maximum difference between torch and triton is {torch.max(torch.abs(torch_output - triton_output))}')
test()