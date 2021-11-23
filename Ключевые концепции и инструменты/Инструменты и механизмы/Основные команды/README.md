**Команда apply**

Эта команда является базовой для компилятора языка Sentinel. Данная команда принимает своим параметром путь к файлу политики. Возьмем простую политику, которая просто проверяет, входит ли текущая дата в определенный интервал.

```
import "time"

# Validate time is between 8 AM and 4 PM
valid_time = rule { time.now.hour >= 8 and time.now.hour < 16 }

# Validate day is M - Th
valid_day = rule {
	time.now.weekday_name in ["Monday", "Tuesday", "Wednesday", "Thursday"]
}

main = rule { valid_time and valid_day }
```

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