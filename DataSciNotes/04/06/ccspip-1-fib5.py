def fib5(n: int) -> int:
    if n == 0: return n  # special case
    xlast: int = 0  # initially set to fib(0)
    xnext: int = 1  # initially set to fib(1)
    for _ in range(1, n):
        xlast, xnext = xnext, xlast + xnext
    return xnext

if __name__ == "__main__":
    print(fib5(5))
    print(fib5(50))