# Результататы работы политик

## is-array-sotred (bubble sort used)

Policy have passed

```
~/sentinel apply is-array-sorted.sentinel
is-array-sorted.sentinel:1:7: requires value for parameter array


  Values can be strings, floats, or JSON array or object values. To force
  strings, use quotes.

  Enter a value: [1, 2, 10, 123] 

Pass - is-array-sorted.sentinel
```

Policy haven't passed
```
~/sentinel apply -param array=[-100,1,-1] is-array-sorted.sentinel  

Fail - is-array-sorted.sentinel

is-array-sorted.sentinel:24:1 - Rule "main"
  Value:
    false
```

## is-array-contains-element (merge sort and binary search used)

Policy have passed:
```
sentinel apply -param array=[-100,1,-1] -param element=-1 is-array-contains-element.sentinel
Pass - is-array-contains-element.sentinel
```

Policy haven't passed:
```
~/sentinel apply -param array=[-100,1,-1] -param element=21 is-array-contains-element.sentinel

Fail - is-array-contains-element.sentinel

is-array-contains-element.sentinel:72:1 - Rule "main"
  Value:
    false
```