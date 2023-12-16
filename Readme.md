# Gas Optimization Example

- Implemented custom error `CanNotDistributeYet()` instead of relying on require messages for enhanced clarity.
- Utilized inline yul assembly to revert with a custom error selector, optimizing gas usage.
- Employed assembly for more efficient transfer of wei to contributors' addresses.
- Utilized immutable variables to store data in deployed bytecode rather than contract storage, reducing gas costs.
- Made the `distribute` function payable to minimize checking opcodes and achieve gas savings.
- Renamed `distribute()` with `0xe4fc6b6d` function selector to `distribute_()` with `0x26e3cc55` func selector to optimize gas usage by placing it before `contributors()` and `distributeTime()` getters, skipping unnecessary checking opcodes.
- Changed `createTime()` to `distributeTime()` for improved clarity of new definition. with new definition it can be immutable and initialized at cinstruct time.
- Adjusted the constructor to be unchecked, as its values cannot experience overflow or underflow, leading to a reduction in gas consumption.

## Comaprison

| src/Distribute.sol:Distribute contract |                 |       |        |       |         |
| -------------------------------------- | --------------- | ----- | ------ | ----- | ------- |
| Deployment Cost                        | Deployment Size |       |        |       |         |
| 317632                                 | 1354            |       |        |       |         |
| Function Name                          | min             | avg   | median | max   | # calls |
| distribute                             | 2453            | 29489 | 29489  | 56526 | 2       |

| src/OptimizedDistribute.sol:Distribute contract |                 |       |        |       |         |
| ----------------------------------------------- | --------------- | ----- | ------ | ----- | ------- |
| Deployment Cost                                 | Deployment Size |       |        |       |         |
| 229938                                          | 1061            |       |        |       |         |
| Function Name                                   | min             | avg   | median | max   | # calls |
| distribute\_                                    | 134             | 26899 | 26899  | 53665 | 2       |

## Compiling contracts

```bash
forge compile
```

## Running tests

```bash
forge test
```

## Running tests with gas report

```bash
forge test --gas-report
```
