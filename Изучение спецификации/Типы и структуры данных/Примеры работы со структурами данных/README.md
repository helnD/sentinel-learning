# Выводы тестовых политик

## Simple sata types
```
Fail - simple_data_types.sentinel

Description:
  Are you Bill Gates?

simple_data_types.sentinel:8:1 - Rule "main"
  Description:
    Are you Bill Gates?

  Value:
    false
```
## Arrays
```
Fail - arrays.sentinel

Description:
  Abstract rule for matrix.

arrays.sentinel:21:1 - Rule "main"
  Description:
    Abstract rule for matrix.

  Value:
    false

arrays.sentinel:11:1 - Rule "matrix_has_only_negative_values"
  Description:
    Matrix have negative values.

  Value:
    false

arrays.sentinel:6:1 - Rule "matrix_have_4"
  Description:
    Matrix have element 4.

  Value:
    false

arrays.sentinel:16:1 - Rule "matrix_length_more_than_10"
  Description:
    Number of rows more than 10.

  Value:
    false
```
## Maps
```
Pass - maps.sentinel
```