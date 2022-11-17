# Push Swap Tester:

Collection of scripts to test the push_swap project from 42 Cursus.

## How to:
On the root of your repository:

```
git clone git@github.com:Jkutkut/42Tester-push_swap.git
```

Run the scripts with:

### Performance:
```
./42Tester-push_swap/tester_performance.sh
```

### Valid and invalid input:
```
./42Tester-push_swap/tester_input.sh
```

### Bonus:
```
./42Tester-push_swap/tester_bonus.sh
```


## Visualizer:
By the use of the visualizer made by [GlaceCoding](https://github.com/GlaceCoding/GlaceCoding.github.io), the following script allows you to see it online:

```
./42Tester-push_swap/visualize.sh <TYPE>
```

**Note 1**: Type can be `small`, `medium`, `big` or `huge`.


**Note 2**: If the type is something else, the script will attempt to run it with those values.

Additionally, if you want to generate a random visualization with the values in a range, you can run:

```
./42Tester-push_swap/visualize.sh custom <MIN> <MAX>
```
