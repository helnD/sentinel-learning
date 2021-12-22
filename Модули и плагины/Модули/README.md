# Модули и плагины

## Модули

Как и во многих языках, в sеntinel есть возможность переиспользовать ранее написанный код, оборачивая его в модули. В модули можно оборачивать функции и политики. Чтобы использовать модули, их нужно сконфигурировать в соответствующем конфигурационном файле.

Рассмотрим создание модулей на практическом примере. Допустим, нам нужен модуль с функциями для работы с точками. Создадим несколько соответствующих функций в файле rectangle.sentinel в текущей директории. В данном модуле содержится несколько функций, связанных с работой с прямоугольниками. Выглядит он так:

```
create_rectangle = func(x, y, width, height) {
    return [x, y, width, height]
}

area = func(rectangle) {
    height = rectangle[2]
    width = rectangle[3]

    return height * width
}

perimetr = func(rectangle) {
    height = rectangle[2]
    width = rectangle[3]

    return (height + width) * 2
}

move = func(rectangle, x_move, y_move) {
    x = rectangle[0]
    y = rectangle[1]
    height = rectangle[2]
    width = rectangle[3]

    return [x + x_move, y + y_move, width, height]
}

are_intersected = func(rectangle_one, rectangle_two) {
    x_left_one = rectangle_one[0]
    y_top_one = rectangle_one[1]
    x_right_one = x_left_one + rectangle_one[2]
    y_bottom_one = y_top_one - rectangle_one[3]

    x_left_two = rectangle_two[0]
    y_top_two = rectangle_two[1]
    x_right_two = x_left_two + rectangle_two[2]
    y_bottom_two = y_top_two - rectangle_two[3]

    diff_x = 0
    if x_left_one < x_left_two {
        diff_x = x_right_two - x_left_one
    } else {
        diff_x = x_right_one - x_left_two
    }

    diff_y = 0
    if y_top_one < y_top_two {
        diff_y = y_top_two - y_bottom_one
    } else {
        diff_y = y_top_one - y_bottom_two
    }

    sum_of_height = rectangle_one[2] + rectangle_two[2]
    sum_of_width = rectangle_one[3] + rectangle_two[3]

    return sum_of_height >= diff_y and sum_of_width >= diff_x
}

print_rectange = func(rectangle) {
    print_array = []
    append(print_array, "x: " + string(rectangle[0]))
    append(print_array, "y: " + string(rectangle[1]))
    append(print_array, "width: " + string(rectangle[2]))
    append(print_array, "height: " + string(rectangle[3]))
    print(print_array)
    print("area: " + string(area(rectangle)))
    print("perimeter: " + string(perimetr(rectangle)))
}
```

Здесь представлено несколько функций по работе с прямоугольником: его создание, вычисление площади и периметра, перемещение, проверка на пересечение и вывод на экран. Теперь, попробуем написать политику, которая будет своеобразной урезанной игрой в сапера. 

У нас будет только одна мина в заранее заданном состоянии и игрок, положение которого тоже задано заранее. Размеры мины 1 х 1, а игрока 3 х 3. Ему предлагается сделать перемещение по заранее заготовленному, неизвестному ему алгоритму, он может указать только перемещение по проекциям x и y. Если в процессе перемещения он попадется на мину, то политика будет провалена:

```
import "rect"

param x_offset
param y_offset

is_explosed = func(bomb, player) {
    position = player

    y_step = 1
    if y_offset < 0 {
        y_step = -1
    }

    x_step = 1
    if x_offset < 0 {
        x_step = -1
    }

    print(position)
    return make_move(position, bomb, x_step, y_step, 0, 0)
}

make_move = func(position, bomb, x_step, y_step, x_offsets, y_offsets) {

    if (rect.are_intersected(position, bomb)) {
        return true
    }

    if x_offsets == x_offset and y_offsets == y_offset {
        return false;
    }

    if x_offsets != x_offset and x_offsets == y_offsets {
        position = rect.move(position, x_step, 0)
        x_offsets += x_step
    } else {
        position = rect.move(position, 0, y_step)
        y_offsets += y_step
    }
    print(position)
    return make_move(position, bomb, x_step, y_step, x_offsets, y_offsets)
}

bomb_rect = rect.create_rectangle(12, 12, 1, 1)
player_rect = rect.create_rectangle(1, 1, 3, 3)

main = rule { not is_explosed(bomb_rect, player_rect)}
```

Как можно заметить, сверху указан импорт нашего модуля, что позволяет использовать функции, для работы с прямоугольниками. Однако, чтобы использовать модули, их нужно сначала настроить в файле конфигурации:

```
module "rect" {
    source = "../rectangle.sentinel"
}
```

Примеры работы (положение бомбы: (12, 12), положение игрока: (1, 1))

```
~/sentinel apply bomb.sentinel
bomb.sentinel:4:7: requires value for parameter x_offset


  Values can be strings, floats, or JSON array or object values. To force
  strings, use quotes.

  Enter a value: -1

bomb.sentinel:5:7: requires value for parameter y_offset


  Values can be strings, floats, or JSON array or object values. To force
  strings, use quotes.

  Enter a value: 5

Pass - bomb.sentinel
```

Случай, когда игрок проиграет:

```
~/sentinel apply bomb.sentinel
sentinel apply bomb.sentinel
bomb.sentinel:4:7: requires value for parameter x_offset


  Values can be strings, floats, or JSON array or object values. To force
  strings, use quotes.

  Enter a value: 11

bomb.sentinel:5:7: requires value for parameter y_offset


  Values can be strings, floats, or JSON array or object values. To force
  strings, use quotes.

  Enter a value: 11

Fail - bomb.sentinel

Print messages:

[1 1 3 3]
[2 1 3 3]
[2 2 3 3]
[3 2 3 3]
[3 3 3 3]
[4 3 3 3]
[4 4 3 3]
[5 4 3 3]
[5 5 3 3]
[6 5 3 3]
[6 6 3 3]
[7 6 3 3]
[7 7 3 3]
[8 7 3 3]
[8 8 3 3]
[9 8 3 3]
[9 9 3 3]
[10 9 3 3]
[10 10 3 3]
[11 10 3 3]
[11 11 3 3]

bomb.sentinel:48:1 - Rule "main"
  Value:
    false
```

Также приведена трассировка ходов игрока (первые 2 элемента массива - x и y соответственно).

## Плагины

Плагины - это особый вид расширения. Этот вид расширения позволяет использовать любой язык программирования, который захочет использовать его разработчик. Это возможность стала доступна благодаря использованию протокола gRCP. Этот протокол позволяет удаленно вызывать процедуры и используется в основном в области микросервисов. 

Sentinel запускает ваш заранее написанный gRCP сервер и обращается к методам, которые вы реализовали.

Однако, как оказалось на практике, в 90% случаев имплементация поддержки этого протокола на Windows в совокупности с Sentinel не работает (https://github.com/hashicorp/terraform/issues/16520). Дело в том, что детального описания того, как именно происходят шаги хостинга вашего сервера.

Я пытался реализовать свой сервер на язые C#. Sentinel определял положение плагина, запускал его и пытался узнать его адрес. На этом моменте не понятно, что именно пытается сделать seentinel. Ясно только то, что нужно как-то передать адрес, но не ясно как именно. Непосредственное обращение к серверу через gRCP клиент проходили успешно.