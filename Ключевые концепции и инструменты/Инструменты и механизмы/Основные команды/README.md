# Команда apply

Эта команда является базовой для компилятора языка Sentinel. Данная команда принимает своим параметром путь к файлу политики. Возьмем простую политику из файла policy_for_apply.sentinel, которая просто проверяет, входит ли текущая дата в определенный интервал.

При вводе команды
```
sentinel apply policy_for_apply.sentinel
```
Вывод будет следующим для успешного прохождения политики:
```
Pass - policy_for_apply.sentinel
```
Для ложного случая будет показана более подробная сводка с трассировкой политик и указанием их значений:
```
Fail - policy_for_apply.sentinel

policy_for_apply.sentinel:11:1 - Rule "main"
  Value:
    false

policy_for_apply.sentinel:7:1 - Rule "valid_day"
  Description:
    Validate day is M - Th

  Value:
    false

policy_for_apply.sentinel:4:1 - Rule "valid_time"
  Description:
    Validate time is between 8 AM and 4 PM

  Value:
    true
```

**Трассировка**

Язык sentinel обладает достаточно хорошим механизмом трассировки, как можно было заметить ранее. Однако ее также можно выводить в более структурированном формате: в виде JSON списка. Особенно это бывает полезным, когда мы используем политики, которые возвращают не булевы значения. Выполним следующую команду для кода из файла policy_for_tracing.sentinel:
```
sentinel apply -json policy_for_tracing.sentinel
```
И увидим такой результат:
```
{
  "can_override": false,
  "error": null,
  "policies": [
    {
      "allowed_failure": false,
      "error": null,
      "policy": "policy_for_tracing.sentinel",
      "result": false,
      "trace": {
        "description": "",
        "error": null,
        "print": "",
        "result": false,
        "rules": {
          "main": {
            "desc": "",
            "ident": "main",
            "position": {
              "filename": "policy_for_tracing.sentinel",
              "offset": 338,
              "line": 11,
              "column": 1
            },
            "value": [
              {
                "weather": "clouds",
                "weekday": "Sunday"
              },
              {
                "weather": "rain",
                "weekday": "Monday"
              },
              {
                "weather": "clouds",
                "weekday": "Thursday"
              },
              {
                "weather": "rain",
                "weekday": "Friday"
              }
            ]
          }
        }
      }
    }
  ],
  "result": false
}
```
Кроме этого мы можем вывести только значения, полученные из конкретной политики.
```
sentinel apply -json-rule main policy_for_tracing.sentinel
``` 
```
[
  {
    "weather": "clouds",
    "weekday": "Sunday"
  },
  {
    "weather": "rain",
    "weekday": "Monday"
  },
  {
    "weather": "clouds",
    "weekday": "Thursday"
  },
  {
    "weather": "rain",
    "weekday": "Friday"
  }
]
```

# Команда test

Данная команда позволяет тестировать политики, используя при этом различные методы.
Для использования этой команды нужно придерживаться четкой структуры каталогов. В папке с описанием политики нужно добавить такую структуру директорий `test/<policy name>/*.[hcl|json]`. Как видно из структуры, нам нужно определить директорию для каждой политики. В данной директории будут различные тестовые случаи. Тестовые случаи описываются в формате hcl или json.

В файле с описанием тестового случая должны быть описаны входные данные политие и их ожидаемые значения. Однако, мы можем не объявлять ожидаемые значения, тогда прохождение/провал теста будет соответствовать прохождению/не прохождению политики. Приведем пример. Попробуем протестировать политику которая по дню и текущему времени определяет рабочее ли сейчас время и лежит в файле policy_for_testing.sentinel, тогда файл с тестовым случаем должен соответствовать структуре test/policy_for_testing/test_case.hcl, данная структура также содержится в текущей директории и выглядит следующим образом:

```
param "day" {
  value = "monday"
}

param "hour" {
  value = 14
}
```

Тогда команда 
```
sentinel test
```
Выводит следующий результат
```
PASS - policy_for_testing.sentinel
  PASS - test\policy_for_testing\test_case.hcl
```

Попробуем провалить тест, добавив некорректные ожидаемые выходные значения. Данный тест назовем incorrect_test_case.hcl и выглядеть он будет так:
```
param "day" {
  value = "monday"
}

param "hour" {
  value = 14
}

test {
  rules = {
    main          = true
    is_open_hours = false
  }
}
```
Здесь мы намерено добавим ошибку и укажем, что если сейчас нерабочее время, то политика должна завершиться успешно. Результат тестирования будет выглядеть так:
```
FAIL - policy_for_testing.sentinel
  FAIL - test\policy_for_testing\incorrect_test_case.hcl
    expected "is_open_hours" to be false, got: true
          true

      policy_for_testing.sentinel:8:1 - Rule "is_open_hours"
        Value:
          true

      policy_for_testing.sentinel:7:1 - Rule "is_weekday"
        Value:
          true
  PASS - test\policy_for_testing\test_case.hcl
```
Наш ошибочный тест не прошел и трассировка объясняет почему именно. Наш первый тест, как и ожидалось, прошел. Заметим, что в ожидаемых значениях теста мы указали только ожидаемые значения для двух политик, хотя в файле их три. Если значения не указаны явно, то ожидаемое значение по умолчанию будет true.

Сейчас мы тестировали файл с политиками, который принимал параметры. Однако не все файлы принимают параметры. Некоторые политики берут различные значения из своего конфигурационного файла. Такие политики также можно тестировать, указав ключевое слово global вместо param в конфигурационном файле теста:
```
global "day" {
  value = "monday"
}

global "hour" {
  value = 14
}
```
Но есть случаи, когда политики берутся не из конфигурационного файла и не из параметров. Значения могут быть взяты из импортируемых библиотек. Например код
```
import "time"
```
импортирует модуль time, в котором содержится одноименная структура, содержащая информацию о дате и времени. Использование такой структуры также может быть протестировано с помощью моков. Например, тест, который дополнительно содержит следующую структуру, заменит значение дня недели и времени при выполнении команды test.
```
mock "time" {
  data = {
    now = {
      weekday_name = "Monday"
      hour         = 14
    }
  }
}
```